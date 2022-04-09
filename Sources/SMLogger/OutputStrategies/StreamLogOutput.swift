//
//  StreamLogOutput.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

open class StreamLogOutput: LogOutput {
    
    public private(set) var stream: TextOutputStream
    
    public init(stream: TextOutputStream) {
        self.stream = stream
    }
    
    public final func write(_ log: String) {
        stream.write(log)
    }
}
