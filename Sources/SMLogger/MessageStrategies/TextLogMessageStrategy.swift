//
//  TextLogMessageStrategy.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

open class TextLogMessageStrategy: LogMessageStrategy {

    public let format: LogMessageFormat
    
    public init(format: LogMessageFormat) {
        self.format = format
    }
    
    public final func generateLog(severity: LogSeverity, items: [Any], separator: String, terminator: String, date: Date, fileName: String, functionName: String, line: Int, column: Int) -> String {
        return format.message(severity: severity, items: items, separator: separator, terminator: terminator, date: date, fileName: fileName, functionName: functionName, line: line, column: column)
    }
    
}

public extension TextLogMessageStrategy {
    
    static let `default`: TextLogMessageStrategy = {
        TextLogMessageStrategy(format: [
            .string("["),
            .severity,
            .string("]"),
            .spaces(untilLength: 8),
            .date(format: .init(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS")),
            .space,
            .filename(componentsCount: 1),
            .string(":"),
            .lineNumber,
            .space,
            .methodName,
            .space,
            .message
        ])
    }()
    
}

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
