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
    
    // MARK: Fatal
    
    public func fatal(_ error: Error, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line, column: Int = #column) {
        log(
            .fatal,
            items: [error.localizedDescription],
            separator: "",
            termiantor: "\n",
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
    }
    
    public func fatal(_ items: Any..., separator: String = " ", termiantor: String = "\n", fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line, column: Int = #column) {
        log(
            .fatal,
            items: items,
            separator: separator,
            termiantor: termiantor,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
    }
    
    // MARK: Error
    
    public func error(_ error: Error, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line, column: Int = #column) {
        log(
            .error,
            items: [error.localizedDescription],
            separator: "",
            termiantor: "\n",
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
    }
    
    public func error(_ items: Any..., separator: String = " ", termiantor: String = "\n", fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line, column: Int = #column) {
        log(
            .error,
            items: items,
            separator: separator,
            termiantor: termiantor,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
    }
    
    // MARK: Warning
    
    public func warning(_ items: Any..., separator: String = " ", termiantor: String = "\n", fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line, column: Int = #column) {
        log(
            .warning,
            items: items,
            separator: separator,
            termiantor: termiantor,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
    }
    
    public func warning(_ error: Error, fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line, column: Int = #column) {
        log(
            .fatal,
            items: [error.localizedDescription],
            separator: "",
            termiantor: "\n",
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
    }
    
    // MARK: Info
    
    public func info(_ items: Any..., separator: String = " ", termiantor: String = "\n", fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line, column: Int = #column) {
        log(
            .info,
            items: items,
            separator: separator,
            termiantor: termiantor,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
    }
    
    // MARK: Debug
    
    public func debug(_ items: Any..., separator: String = " ", termiantor: String = "\n", fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line, column: Int = #column) {
        log(
            .debug,
            items: items,
            separator: separator,
            termiantor: termiantor,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
    }
    
    // MARK: Trace
    
    public func trace(_ items: Any..., separator: String = " ", termiantor: String = "\n", fileName: String = #file, date: Date = Date(), functionName: String = #function, line: Int = #line, column: Int = #column) {
        log(
            .trace,
            items: items,
            separator: separator,
            termiantor: termiantor,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
    }
    
    // MARK: Generic log
    
    public func log(_ severity: LogSeverity, items: [Any], separator: String, termiantor: String, date: Date = Date(), fileName: String, functionName: String, line: Int, column: Int) {
        strategies.forEach { strategy in
            guard strategy.validSeverities.contains(severity) else {
                return
            }
            strategy.perform(severity: severity, items: items, separator: separator, terminator: termiantor, date: date, fileName: fileName, functionName: functionName, line: line, column: column)
        }
    }
    
}
