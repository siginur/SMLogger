//
//  LogMessageSegment.swift
//  
//
//  Created by Alexey Siginur on 18/08/2020.
//

import Foundation

public enum LogMessageSegment {
    case severity
    case date(format: DateFormatter)
    case filename(componentsCount: Int)
    case lineNumber
    case methodName
    case message
    case space
    case spaces(untilLength: Int)
    case string(String)
}

public typealias LogMessageFormat = [LogMessageSegment]

public extension Array where Element == LogMessageSegment {
    func message(level: LogLevel, message: String, date: Date, fileName: String, functionName: String, line: Int) -> String {
        var log: String = ""
        for logPart in self {
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
        return log
    }
}
