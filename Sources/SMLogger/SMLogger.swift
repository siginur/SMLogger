//
//  SMLogger.swift
//
//
//  Created by Alexey Siginur on 06/08/2020.
//

import Foundation

public class SMLogger {
    
    public let configuration: Configuration
    
    public init(configuration: Configuration? = nil) {
        self.configuration = configuration ?? Configuration.default
    }
    
    public func error(_ error: Error, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line) {
        log(
            .error,
            message: error.localizedDescription,
            configuration: configuration,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line
        )
    }
    
    public func error(_ message: String, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line) {
        log(
            .error,
            message: message,
            configuration: configuration,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line
        )
    }
    
    public func debug(_ message: String, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line) {
        log(
            .debug,
            message: message,
            configuration: configuration,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line
        )
    }
    
    public func warning(_ message: String, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line) {
        log(
            .warning,
            message: message,
            configuration: configuration,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line
        )
    }
    
    public func info(_ message: String, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line) {
        log(
            .info,
            message: message,
            configuration: configuration,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line
        )
    }
    
    public func log(_ level: Level, message: String, configuration: Configuration, date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line) {
        var log: String = ""
        for logPart in configuration.format {
            switch logPart {
            case .severity:
                log += level.rawValue.uppercased()
            case .date(let format):
                log += format.string(from: date)
            case .filename(let componentsCount):
                if componentsCount > 0 {
                    var pathComponents = (fileName as NSString).pathComponents
                    if pathComponents.first == "/" {
                        pathComponents.removeFirst()
                    }
                    pathComponents.removeFirst(max(pathComponents.count - componentsCount, 0))
                    log += pathComponents.joined(separator: "/")
                }
                else {
                    log += fileName
                }
            case .line:
                log += "\(line)"
            case .method:
                log += functionName
            case .message:
                log += message
            case .space:
                log += " "
            case .spaces(let length):
                while log.count < length {
                    log += " "
                }
            case .string(let string):
                log += string
            }
        }
        print(log)
    }
    
}
