//
//  JSONLogMessageFormat.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

open class JSONLogMessageFormat: LogMessageFormat {

    public let segments: [String: LogMessageSegmentList]
    
    public init(segments: [String: LogMessageSegmentList]) {
        self.segments = segments
    }
    
    public convenience init(format: [String: LogMessageSegment]) {
        self.init(segments: format.mapValues { [$0] })
    }
    
    public final func generateLog(_ logData: LogData) -> String {
        let log: [String: String] = segments.mapValues {
            $0.message(from: logData)
        }
        guard let json = try? JSONEncoder().encode(log) else {
            return ""
        }
        return String(data: json, encoding: .utf8) ?? ""
    }
    
}

public extension JSONLogMessageFormat {
    
    static let `default`: JSONLogMessageFormat = {
        JSONLogMessageFormat(format: [
            "severity": .severity,
            "date": .date(format: .init(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS")),
            "filename": .filename(componentsCount: 1),
            "lineNumber": .lineNumber,
            "methodName": .methodName,
            "message": .message
        ])
    }()
    
    static let `defaultCompact`: JSONLogMessageFormat = {
        JSONLogMessageFormat(format: [
            "s": .severity,
            "d": .date(format: .init(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS")),
            "fn": .filename(componentsCount: 1),
            "l": .lineNumber,
            "m": .methodName,
            "msg": .message
        ])
    }()
    
}
