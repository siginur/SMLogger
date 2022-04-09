//
//  ConsoleLogOutput.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

open class ConsoleLogOutput: LogOutput {
    
    public init() {}
    
    public final func write(_ log: String) {
        print(log, terminator: "")
    }
    
}
