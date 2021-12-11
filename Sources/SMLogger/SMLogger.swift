//
//  SMLogger.swift
//
//
//  Created by Alexey Siginur on 06/08/2020.
//

import Foundation

public class SMLogger {
    
    private let strategyGroup: LogStrategyGroup

    public var strategies: [LogStrategy] { strategyGroup.strategies }

    public init(strategies: [LogStrategy]) {
        self.strategyGroup = LogStrategyGroup(strategies: strategies)
    }
    
    public convenience init(strategy: LogStrategy) {
        self.init(strategies: [strategy])
    }
    
    public func error(_ error: Error, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line) {
        log(
            .error,
            message: error.localizedDescription,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line
        )
    }
    
    public func error(_ message: String, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line) {
        log(
            .error,
            message: message,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line
        )
    }
    
    public func debug(_ message: String, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line) {
        log(
            .debug,
            message: message,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line
        )
    }
    
    public func warning(_ message: String, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line) {
        log(
            .warning,
            message: message,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line
        )
    }
    
    public func info(_ message: String, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line) {
        log(
            .info,
            message: message,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line
        )
    }
    
    public func log(_ severity: LogSeverity, message: String, date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line) {
        strategies.forEach { strategy in
            guard strategy.validSeverities.contains(severity) else {
                return
            }
            strategy.perform(severity: severity, message: message, date: date, fileName: fileName, functionName: functionName, line: line)
        }
    }
    
}
