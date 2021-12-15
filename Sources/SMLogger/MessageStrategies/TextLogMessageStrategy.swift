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
    
    public final func generateLog(_ logData: LogData) -> String {
        return format.message(from: logData)
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
