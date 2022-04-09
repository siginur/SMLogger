//
//  TextLogMessageFormat.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

open class TextLogMessageFormat: LogMessageFormat {

    public let segments: LogMessageSegmentList
    
    public init(segments: LogMessageSegmentList) {
        self.segments = segments
    }
    
    public final func generateLog(_ logData: LogData) -> String {
        return segments.message(from: logData)
    }
    
}

public extension TextLogMessageFormat {
    
    static let `default`: TextLogMessageFormat = {
        TextLogMessageFormat(segments: [
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
