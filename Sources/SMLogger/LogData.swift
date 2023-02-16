//
//  LogData.swift
//  
//
//  Created by Alexey Siginur on 15/12/2021.
//

import Foundation

public struct LogData {
    public let severity: LogSeverity
    public let items: [Any]
    public let separator: String
    public let terminator: String
    public let date: Date
    public let fileName: String
    public let functionName: String
    public let line: Int
    public let column: Int
    public let extraInfo: [String: Any]
    
    public init(severity: LogSeverity, items: [Any], separator: String, terminator: String, date: Date, fileName: String, functionName: String, line: Int, column: Int, extraInfo: [String: Any]) {
        self.severity = severity
        self.items = items
        self.separator = separator
        self.terminator = terminator
        self.date = date
        self.fileName = fileName
        self.functionName = functionName
        self.line = line
        self.column = column
        self.extraInfo = extraInfo
    }
}
