//
//  MemoryLogOutput.swift
//  
//
//  Created by Alexey Siginur on 10/04/2022.
//

import Foundation

open class MemoryLogOutput: LogOutput {
    
    public private(set) var logs: String = ""
    
    public init() {}
    
    public final func write(_ log: String) {
        logs += log
    }
    
    public func clear() {
        self.logs = ""
    }
}
