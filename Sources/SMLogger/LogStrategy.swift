//
//  LogStrategy.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

public protocol LogMessageStrategy {
    func generateLog(level: LogLevel, message: String, date: Date, fileName: String, functionName: String, line: Int) -> String
}

public protocol LogOutputStrategy {
    func write(_ log: String)
}

public struct LogStrategy {
    public let message: LogMessageStrategy
    public let output: LogOutputStrategy
    
    public init(message: LogMessageStrategy, output: LogOutputStrategy) {
        self.message = message
        self.output = output
    }
    
    func perform(level: LogLevel, message: String, date: Date, fileName: String, functionName: String, line: Int) {
        let log = self.message.generateLog(level: level, message: message, date: date, fileName: fileName, functionName: functionName, line: line)
        output.write(log)
    }
}

public extension LogStrategy {
    static let `default` = LogStrategy(message: TextLogMessageStrategy.default, output: ConsoleLogOutputStrategy())
}

struct LogStrategyGroup {
    let strategies: [LogStrategy]
    
    init(strategies: [LogStrategy]) {
        self.strategies = strategies
    }
    
    init(messageStrategies: [LogMessageStrategy], outputStrategies: [LogOutputStrategy]) {
        var strategies = [LogStrategy]()
        for message in messageStrategies {
            for output in outputStrategies {
                strategies.append(LogStrategy(message: message, output: output))
            }
        }
        self.init(strategies: strategies)
    }
    
    init(messageStrategies: [LogMessageStrategy], outputStrategy: LogOutputStrategy) {
        self.init(messageStrategies: messageStrategies, outputStrategies: [outputStrategy])
    }
    
    init(messageStrategy: LogMessageStrategy, outputStrategies: [LogOutputStrategy]) {
        self.init(messageStrategies: [messageStrategy], outputStrategies: outputStrategies)
    }
    
    init(messageStrategy: LogMessageStrategy, outputStrategy: LogOutputStrategy) {
        self.init(strategies: [LogStrategy(message: messageStrategy, output: outputStrategy)])
    }
    
}
