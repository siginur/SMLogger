//
//  JSONLogMessageStrategy.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

public final class JSONLogMessageStrategy: LogMessageStrategy {

    public let format: [String: LogMessageFormat]
    
    public init(format: [String: LogMessageFormat]) {
        self.format = format
    }
    
    public convenience init(format: [String: LogMessageSegment]) {
        self.init(format: format.mapValues { [$0] })
    }
    
    public final func generateLog(level: LogLevel, message: String, date: Date, fileName: String, functionName: String, line: Int) -> String {
        let log: [String: String] = format.mapValues {
            $0.message(level: level, message: message, date: date, fileName: fileName, functionName: functionName, line: line)
        }
        guard let json = try? JSONEncoder().encode(log) else {
            return ""
        }
        return String(data: json, encoding: .utf8) ?? ""
    }
    
}

public extension JSONLogMessageStrategy {
    
    static let `default`: JSONLogMessageStrategy = {
        JSONLogMessageStrategy(format: [
            "severity": .severity,
            "date": .date(format: .init(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS")),
            "filename": .filename(componentsCount: 1),
            "lineNumber": .lineNumber,
            "methodName": .methodName,
            "message": .message
        ])
    }()
    
    static let `defaultCompact`: JSONLogMessageStrategy = {
        JSONLogMessageStrategy(format: [
            "s": .severity,
            "d": .date(format: .init(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS")),
            "fn": .filename(componentsCount: 1),
            "l": .lineNumber,
            "m": .methodName,
            "msg": .message
        ])
    }()
    
}
