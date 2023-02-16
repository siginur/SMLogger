//
//  LogLevel.swift
//  
//
//  Created by Alexey Siginur on 18/08/2020.
//

public struct LogSeverity: Comparable, Hashable {
    
    public static let fatal = LogSeverity(tag: "fatal", priority: 1000)
    public static let error = LogSeverity(tag: "error", priority: 800)
    public static let warning = LogSeverity(tag: "warn", priority: 600)
    public static let info = LogSeverity(tag: "info", priority: 400)
    public static let debug = LogSeverity(tag: "debug", priority: 200)
    public static let trace = LogSeverity(tag: "trace", priority: 100)

    let tag: String
    let priority: Int
    
    public static func >=(lhs: LogSeverity, rhs: LogSeverity) -> Bool {
        return lhs.priority >= rhs.priority
    }

    public static func <(lhs: LogSeverity, rhs: LogSeverity) -> Bool {
        return lhs.priority < rhs.priority
    }
    
}

public enum LogSeverityFilter {
    case all
    case min(LogSeverity)
    case max(LogSeverity)
    case range(ClosedRange<LogSeverity>)
    case exclude(Set<LogSeverity>)
    case include(Set<LogSeverity>)
    
    public func pass(_ logSeverity: LogSeverity) -> Bool {
        switch self {
        case .all:
            return true
        case .min(let min):
            return logSeverity >= min
        case .max(let max):
            return logSeverity <= max
        case .range(let range):
            return range.contains(logSeverity)
        case .exclude(let exclude):
        	return exclude.contains(logSeverity) == false
        case .include(let include):
        	return include.contains(logSeverity) == true
        }
    }
}
