//
//  LogMessageSegmentList.swift
//  
//
//  Created by Alexey Siginur on 14/12/2021.
//

import Foundation

public typealias LogMessageSegmentList = [LogMessageSegment]

public extension Array where Element == LogMessageSegment {
    func message(from logData: LogData) -> String {
        var log: String = ""
        for logPart in self {
            switch logPart {
            case .severity:
                log += logData.severity.rawValue.uppercased()
            case .date(let format):
                log += format.string(from: logData.date)
            case .filename(let componentsCount):
                if componentsCount > 0 {
                    var pathComponents = (logData.fileName as NSString).pathComponents
                    if pathComponents.first == "/" {
                        pathComponents.removeFirst()
                    }
                    pathComponents.removeFirst(Swift.max(pathComponents.count - componentsCount, 0))
                    log += pathComponents.joined(separator: "/")
                }
                else {
                    log += logData.fileName
                }
            case .lineNumber:
                log += "\(logData.line)"
            case .columnNumber:
                log += "\(logData.column)"
            case .methodName:
                log += logData.functionName
            case .message:
                log += logData.items.map({ String(describing: $0) }).joined(separator: logData.separator) + logData.terminator
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
