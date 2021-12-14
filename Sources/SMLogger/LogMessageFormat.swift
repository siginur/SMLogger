//
//  LogMessageFormat.swift
//  
//
//  Created by Alexey Siginur on 14/12/2021.
//

import Foundation

public typealias LogMessageFormat = [LogMessageSegment]

public extension Array where Element == LogMessageSegment {
    func message(severity: LogSeverity, message: String, date: Date, fileName: String, functionName: String, line: Int) -> String {
        var log: String = ""
        for logPart in self {
            switch logPart {
            case .severity:
                log += severity.rawValue.uppercased()
            case .date(let format):
                log += format.string(from: date)
            case .filename(let componentsCount):
                if componentsCount > 0 {
                    var pathComponents = (fileName as NSString).pathComponents
                    if pathComponents.first == "/" {
                        pathComponents.removeFirst()
                    }
                    pathComponents.removeFirst(Swift.max(pathComponents.count - componentsCount, 0))
                    log += pathComponents.joined(separator: "/")
                }
                else {
                    log += fileName
                }
            case .lineNumber:
                log += "\(line)"
            case .methodName:
                log += functionName
            case .message:
                log += message
            case .space(let count):
                log += String(repeating: " ", count: count)
            case .spaces(let length):
                while log.count < length {
                    log += " "
                }
            case .tab(let count):
                log += String(repeating: "\t", count: count)
            case .string(let string):
                log += string
            }
        }
        return log
    }
}
