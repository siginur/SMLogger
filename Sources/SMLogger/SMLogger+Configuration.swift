//
//  SMLogger+Configuration.swift
//  
//
//  Created by Alexey Siginur on 18/08/2020.
//

public extension SMLogger {
    
    struct Configuration {
        
        let format: [LogSegment]
        
        public init(format: [LogSegment]) {
            self.format = format
        }
        
    }
    
}
