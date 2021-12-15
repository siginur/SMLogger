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
    case columnNumber
    case methodName
    case message
    case tab(count: Int)
    case space(count: Int)
    case spaces(untilLength: Int)
    case string(String)
    
    public static let tab = LogMessageSegment.tab(count: 1)
    public static let space = LogMessageSegment.space(count: 1)
    
    public static func date(format: String) -> LogMessageSegment {
        return .date(format: DateFormatter(dateFormat: format))
    }
    
    public static func string(format: String, args: CVarArg...) -> LogMessageSegment {
        return .string(String(format: format, args))
    }
    
    public static func string(_ string: String, minLength: Int, prefix: Character) -> LogMessageSegment {
        return .string(string.modify(minLength: minLength, prefix: prefix))
    }
    
    public static func string(_ string: String, minLength: Int, suffix: Character) -> LogMessageSegment {
        return .string(string.modify(minLength: minLength, suffix: suffix))
    }

    public static func string(_ string: String, maxLength: Int) -> LogMessageSegment {
        return .string(string.modify(maxLength: maxLength))
    }
    
    public static func string(_ string: String, minLength: Int, prefix: Character, maxLength: Int) -> LogMessageSegment {
        return .string(string.modify(minLength: minLength, prefix: prefix).modify(maxLength: maxLength))
    }
    
    public static func string(_ string: String, minLength: Int, suffix: Character, maxLength: Int) -> LogMessageSegment {
        return .string(string.modify(minLength: minLength, suffix: suffix).modify(maxLength: maxLength))
    }
}

fileprivate extension String {
    func modify(minLength: Int, prefix: Character) -> String {
        var string = self
        while self.count < minLength {
            string = String(prefix) + string
        }
        return string
    }
    
    func modify(minLength: Int, suffix: Character) -> String {
        var string = self
        while string.count < minLength {
            string = string + String(suffix)
        }
        return string
    }
    
    func modify(maxLength: Int) -> String {
        var string = self
        if string.count > maxLength {
            string.removeLast(string.count - maxLength)
        }
        return string
    }
}
