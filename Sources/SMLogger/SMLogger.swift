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
    
    public func fatal(_ error: Error, date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .fatal,
            items: [error.localizedDescription],
            separator: "",
            terminator: "\n",
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
        self.log(logData)
    }
    
    public func fatal(_ items: Any..., separator: String = " ", terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .fatal,
            items: items,
            separator: separator,
            terminator: terminator,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
        self.log(logData)
    }
    
    // MARK: Error
    
    public func error(_ error: Error, date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .error,
            items: [error.localizedDescription],
            separator: "",
            terminator: "\n",
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
        self.log(logData)
    }
    
    public func error(_ items: Any..., separator: String = " ", terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .error,
            items: items,
            separator: separator,
            terminator: terminator,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
        self.log(logData)
    }
    
    // MARK: Warning
    
    public func warning(_ items: Any..., separator: String = " ", terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .warning,
            items: items,
            separator: separator,
            terminator: terminator,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
        self.log(logData)
    }
    
    public func warning(_ error: Error, date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .fatal,
            items: [error.localizedDescription],
            separator: "",
            terminator: "\n",
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
        self.log(logData)
    }
    
    // MARK: Info
    
    public func info(_ items: Any..., separator: String = " ", terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .info,
            items: items,
            separator: separator,
            terminator: terminator,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
        self.log(logData)
    }
    
    // MARK: Debug
    
    public func debug(_ items: Any..., separator: String = " ", terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .debug,
            items: items,
            separator: separator,
            terminator: terminator,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
        self.log(logData)
    }
    
    // MARK: Trace
    
    public func trace(_ items: Any..., separator: String = " ", terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .trace,
            items: items,
            separator: separator,
            terminator: terminator,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
        self.log(logData)
    }
    
    // MARK: Generic log
    
    public func log(_ severity: LogSeverity, items: [Any], separator: String, terminator: String, date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: severity,
            items: items,
            separator: separator,
            terminator: terminator,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
        self.log(logData)
    }
    
    // MARK: - Private method
    
    private func log(_ logData: LogData) {
        strategies.forEach { strategy in
            guard strategy.validSeverities.contains(logData.severity) else {
                return
            }
            strategy.perform(logData)
        }
    }
    
}
