//
//  LogStrategy.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

public protocol LogMessageStrategy {
    func generateLog(severity: LogSeverity, message: String, date: Date, fileName: String, functionName: String, line: Int) -> String
}

public protocol LogOutputStrategy {
    func write(_ log: String)
}

public struct LogStrategy {
    public let message: LogMessageStrategy
    public let output: LogOutputStrategy
    public let validSeverities: Set<LogSeverity>
    
    public init(message: LogMessageStrategy, output: LogOutputStrategy, severityFilter: LogSeverityFilter = .all) {
        self.message = message
        self.output = output
        self.validSeverities = severityFilter.validSeverities
    }
    
    func perform(severity: LogSeverity, message: String, date: Date, fileName: String, functionName: String, line: Int) {
        let log = self.message.generateLog(severity: severity, message: message, date: date, fileName: fileName, functionName: functionName, line: line)
        output.write(log)
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
    
    init(messageStrategies: [LogMessageStrategy], outputStrategies: [LogOutputStrategy], severityFilter: LogSeverityFilter) {
        var strategies = [LogStrategy]()
        for message in messageStrategies {
            for output in outputStrategies {
                strategies.append(LogStrategy(message: message, output: output, severityFilter: severityFilter))
            }
        }
        self.init(strategies: strategies)
    }
    
    init(messageStrategies: [LogMessageStrategy], outputStrategy: LogOutputStrategy, severityFilter: LogSeverityFilter) {
        self.init(messageStrategies: messageStrategies, outputStrategies: [outputStrategy], severityFilter: severityFilter)
    }
    
    init(messageStrategy: LogMessageStrategy, outputStrategies: [LogOutputStrategy], severityFilter: LogSeverityFilter) {
        self.init(messageStrategies: [messageStrategy], outputStrategies: outputStrategies, severityFilter: severityFilter)
    }
    
    init(messageStrategy: LogMessageStrategy, outputStrategy: LogOutputStrategy, severityFilter: LogSeverityFilter) {
        self.init(strategies: [LogStrategy(message: messageStrategy, output: outputStrategy, severityFilter: severityFilter)])
    }
    
}
