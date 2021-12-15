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
    
    public func fatal(error: Error, terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .fatal,
            items: [error.localizedDescription],
            separator: "",
            terminator: terminator,
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
    
    public func fatal(format: String, _ arguments: CVarArg..., terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .fatal,
            items: [String(format: format, arguments: arguments)],
            separator: "",
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
    
    public func error(error: Error, terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .error,
            items: [error.localizedDescription],
            separator: "",
            terminator: terminator,
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
    
    public func error(format: String, _ arguments: CVarArg..., terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .error,
            items: [String(format: format, arguments: arguments)],
            separator: "",
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
    
    public func warning(error: Error, terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .fatal,
            items: [error.localizedDescription],
            separator: "",
            terminator: terminator,
            date: date,
            fileName: fileName,
            functionName: functionName,
            line: line,
            column: column
        )
        self.log(logData)
    }
    
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
    
    public func warning(format: String, _ arguments: CVarArg..., terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .warning,
            items: [String(format: format, arguments: arguments)],
            separator: "",
            terminator: terminator,
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
    
    public func info(format: String, _ arguments: CVarArg..., terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .info,
            items: [String(format: format, arguments: arguments)],
            separator: "",
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
    
    public func debug(format: String, _ arguments: CVarArg..., terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .debug,
            items: [String(format: format, arguments: arguments)],
            separator: "",
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
    
    public func trace(format: String, _ arguments: CVarArg..., terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: .trace,
            items: [String(format: format, arguments: arguments)],
            separator: "",
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
    
    public func log(_ severity: LogSeverity, items: Any..., separator: String = " ", terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
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
    
    public func log(_ severity: LogSeverity, format: String, _ arguments: CVarArg..., terminator: String = "\n", date: Date = Date(), fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        let logData = LogData(
            severity: severity,
            items: [String(format: format, arguments: arguments)],
            separator: "",
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
