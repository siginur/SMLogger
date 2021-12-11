//
//  FileLogOutputStrategy.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

open class FileLogOutputStrategy: LogOutputStrategy {
    
    public enum ArchivePolicy {
        case daily
        case weekly
        case monthly
        case lineLimit(UInt)
        case sizeLimit(bytes: UInt64)
    }
    
    enum Error: Swift.Error {
        case wrongURL
        case directoryDoesNotExists
        case unableToCreateLogFile
    }
    
    private let logsDirectory: URL
    private let fileManager = FileManager.default
    private var fileHandle: FileHandle
    private var fileCreationDateComponents: DateComponents
    private var fileSize: UInt64
    private var fileLinesCount: UInt
    public let fileURL: URL
    public let filename: String
    public let archivePolicy: ArchivePolicy
    
    public init(directory: URL, filename: String, archivePolicy: ArchivePolicy) throws {
        guard directory.isFileURL == false else {
            throw Error.wrongURL
        }
        guard fileManager.fileExists(atPath: directory.absoluteString) else {
            throw Error.directoryDoesNotExists
        }
        
        self.logsDirectory = directory
        self.fileURL = directory.appendingPathComponent("\(filename).log")
        self.filename = filename
        self.archivePolicy = archivePolicy
        
        self.fileHandle = FileHandle()
        self.fileCreationDateComponents = Calendar.current.dateComponents([.year, .month, .day, .weekOfYear], from: Date())
        self.fileSize = 0
        self.fileLinesCount = 0
        try preapreLogFile()
    }
    
    public final func write(_ log: String) {
        guard let data = log.data(using: .utf8) else {
            return
        }
        self.fileHandle.write(data)
        self.fileSize += UInt64(data.count)
        self.fileLinesCount += 1
        
        if validateEndOfFile() {
            try? archiveLogs()
        }
    }
    
    private func validateEndOfFile() -> Bool {
        switch self.archivePolicy {
        case .daily:
            let current = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            return current.year != fileCreationDateComponents.year && current.month != fileCreationDateComponents.month && current.day != fileCreationDateComponents.day
        case .weekly:
            let current = Calendar.current.dateComponents([.year, .weekOfYear], from: Date())
            return current.year != fileCreationDateComponents.year && current.weekOfYear != fileCreationDateComponents.weekOfYear
        case .monthly:
            let current = Calendar.current.dateComponents([.year, .month], from: Date())
            return current.year != fileCreationDateComponents.year && current.month != fileCreationDateComponents.month
        case .lineLimit(let maxLines):
            return fileLinesCount >= maxLines
        case .sizeLimit(let maxBytes):
            return fileSize >= maxBytes
        }
    }
    
    private func archiveLogs() throws {
        if #available(macOS 10.15.0, iOS 13.0, watchOS 6.0, tvOS 13.0, *) {
            try self.fileHandle.close()
        } else {
            self.fileHandle.closeFile()
        }
        
        let datestamp = DateFormatter(dateFormat: "YYYYMMddHHmmss").string(from: Date())
        let archivedFileURL = logsDirectory.appendingPathComponent("\(self.filename)-\(datestamp).log")
        try self.fileManager.moveItem(at: self.fileURL, to: archivedFileURL)
        
        try self.fileManager.removeItem(at: self.fileURL)
        try preapreLogFile()
    }
    
    private func preapreLogFile() throws {
        let filePath = self.fileURL.absoluteString
        if fileManager.fileExists(atPath: filePath) == false {
            guard fileManager.createFile(atPath: filePath, contents: nil, attributes: nil) else {
                throw Error.unableToCreateLogFile
            }
        }
        self.fileLinesCount = UInt(((try? String(contentsOf: self.fileURL)) ?? "").components(separatedBy: "\n").count)

        self.fileHandle = try FileHandle(forWritingTo: self.fileURL)
        if #available(macOS 10.15.4, iOS 13.4, watchOS 6.2, tvOS 13.4, *) {
            try self.fileHandle.seekToEnd()
        } else {
            self.fileHandle.seekToEndOfFile()
        }
        
        let fileAttributes = (try? self.fileManager.attributesOfItem(atPath: filePath) as [FileAttributeKey:Any]) ?? [:]
        let creationDate = fileAttributes[FileAttributeKey.size] as? Date ?? Date()
        self.fileCreationDateComponents = Calendar.current.dateComponents([.year, .month, .day, .weekOfYear], from: creationDate)
        self.fileSize = (fileAttributes[FileAttributeKey.size] as? NSNumber)?.uint64Value ?? 0
    }
    
}

public extension FileLogOutputStrategy {
    
    static let `default`: FileLogOutputStrategy = {
        let directory = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        return try! FileLogOutputStrategy(directory: directory, filename: "logs", archivePolicy: .sizeLimit(bytes: 1024 * 1024))
    }()
    
}
