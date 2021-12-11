//
//  ConsoleLogOutputStrategy.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

open class ConsoleLogOutputStrategy: LogOutputStrategy {
    
    public init() {}
    
    public final func write(_ log: String) {
        print(log)
    }
    
}
