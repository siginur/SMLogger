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
}
