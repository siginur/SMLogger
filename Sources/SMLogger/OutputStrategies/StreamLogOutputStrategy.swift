//
//  StreamLogOutputStrategy.swift
//  
//
//  Created by Alexey Siginur on 11/12/2021.
//

import Foundation

public class StreamLogOutputStrategy: LogOutputStrategy {
    
    public var stream: TextOutputStream
    
    public init(stream: TextOutputStream) {
        self.stream = stream
    }
    
    public func write(_ log: String) {
        stream.write(log)
    }
}
