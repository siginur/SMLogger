//
//  LogStrategy.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

public protocol LogMessageFormat {
    func generateLog(_ logData: LogData) -> String
}

public protocol LogOutput {
    func write(_ log: String)
}

open class LogStrategy {
    private let queue = DispatchQueue(label: "com.merkova.smlogger.\(UUID().uuidString)", qos: .utility)
    public let message: LogMessageFormat
    public let output: LogOutput
    public let severityFilter: LogSeverityFilter
    public var active: Bool = true
    
    public init(message: LogMessageFormat, output: LogOutput, severityFilter: LogSeverityFilter = .all) {
        self.message = message
        self.output = output
        self.severityFilter = severityFilter
    }
    
    func perform(_ logData: LogData) {
        queue.sync {
            let log = self.message.generateLog(logData)
            output.write(log)
        }
    }
}

public extension LogStrategy {
    static let `default` = LogStrategy(message: TextLogMessageFormat.default, output: ConsoleLogOutput(), severityFilter: .all)
}

struct LogStrategyGroup {
    let strategies: [LogStrategy]
    
    init(strategies: [LogStrategy]) {
        self.strategies = strategies
    }
    
    init(messageStrategy: LogMessageFormat, outputStrategies: [LogOutput], severityFilter: LogSeverityFilter) {
        var strategies = [LogStrategy]()
        for output in outputStrategies {
            strategies.append(LogStrategy(message: messageStrategy, output: output, severityFilter: severityFilter))
        }
        self.init(strategies: strategies)
    }
    
    init(messageStrategy: LogMessageFormat, outputStrategies: [(LogOutput, LogSeverityFilter)]) {
        var strategies = [LogStrategy]()
        for output in outputStrategies {
            strategies.append(LogStrategy(message: messageStrategy, output: output.0, severityFilter: output.1))
        }
        self.init(strategies: strategies)
    }
    
    init(messageStrategy: LogMessageFormat, outputStrategy: LogOutput, severityFilter: LogSeverityFilter) {
        let strategy = LogStrategy(message: messageStrategy, output: outputStrategy, severityFilter: severityFilter)
        self.init(strategies: [strategy])
    }
    
}
