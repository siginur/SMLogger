//
//  LogStrategy.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

public protocol LogMessageStrategy {
    func generateLog(severity: LogSeverity, items: [Any], separator: String, terminator: String, date: Date, fileName: String, functionName: String, line: Int, column: Int) -> String
}

public protocol LogOutputStrategy {
    func write(_ log: String)
}

open class LogStrategy {
    private let queue = DispatchQueue(label: "com.merkova.smlogger.\(UUID().uuidString)", qos: .utility)
    public let message: LogMessageStrategy
    public let output: LogOutputStrategy
    public let validSeverities: Set<LogSeverity>
    
    public init(message: LogMessageStrategy, output: LogOutputStrategy, severityFilter: LogSeverityFilter = .all) {
        self.message = message
        self.output = output
        self.validSeverities = severityFilter.validSeverities
    }
    
    func perform(severity: LogSeverity, items: [Any], separator: String, terminator: String, date: Date, fileName: String, functionName: String, line: Int, column: Int) {
        queue.sync {
            let log = self.message.generateLog(severity: severity, items: items, separator: separator, terminator: terminator, date: date, fileName: fileName, functionName: functionName, line: line, column: column)
            output.write(log)
        }
    }
}

public extension LogStrategy {
    static let `default` = LogStrategy(message: TextLogMessageStrategy.default, output: ConsoleLogOutputStrategy(), severityFilter: .all)
}

struct LogStrategyGroup {
    let strategies: [LogStrategy]
    
    init(strategies: [LogStrategy]) {
        self.strategies = strategies
    }
    
    init(messageStrategy: LogMessageStrategy, outputStrategies: [LogOutputStrategy], severityFilter: LogSeverityFilter) {
        var strategies = [LogStrategy]()
        for output in outputStrategies {
            strategies.append(LogStrategy(message: messageStrategy, output: output, severityFilter: severityFilter))
        }
        self.init(strategies: strategies)
    }
    
    init(messageStrategy: LogMessageStrategy, outputStrategies: [(LogOutputStrategy, LogSeverityFilter)]) {
        var strategies = [LogStrategy]()
        for output in outputStrategies {
            strategies.append(LogStrategy(message: messageStrategy, output: output.0, severityFilter: output.1))
        }
        self.init(strategies: strategies)
    }
    
    init(messageStrategy: LogMessageStrategy, outputStrategy: LogOutputStrategy, severityFilter: LogSeverityFilter) {
        let strategy = LogStrategy(message: messageStrategy, output: outputStrategy, severityFilter: severityFilter)
        self.init(strategies: [strategy])
    }
    
}
