//
//  LogLevel.swift
//  
//
//  Created by Alexey Siginur on 18/08/2020.
//

public enum LogSeverity: String, CaseIterable, Comparable {
    case error
    case warning = "warn"
    case info
    case debug
    
    var priority: Int {
        switch self {
        case .error:   return 4
        case .warning: return 3
        case .info:    return 2
        case .debug:   return 1
        }
    }
    
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
    
    public var validSeverities: Set<LogSeverity> {
        switch self {
        case .all:
            return Set(LogSeverity.allCases)
        case .min(let min):
            return Set(LogSeverity.allCases.filter { $0 >= min })
        case .max(let max):
            return Set(LogSeverity.allCases.filter { $0 <= max })
        case .range(let range):
            return Set(LogSeverity.allCases.filter { range.contains($0) })
        case .exclude(let exclude):
            return Set(LogSeverity.allCases.filter { !exclude.contains($0) })
        case .include(let include):
            return include
        }
    }
}