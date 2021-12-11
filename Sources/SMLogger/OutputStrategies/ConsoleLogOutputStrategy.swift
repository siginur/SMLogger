//
//  ConsoleLogOutputStrategy.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

public class ConsoleLogOutputStrategy: LogOutputStrategy {
    
    public init() {}
    
    public func write(_ log: String) {
        print(log)
    }
    
}
