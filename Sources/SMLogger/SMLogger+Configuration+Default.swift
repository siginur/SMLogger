//
//  SMLogger+Configuration+Default.swift
//  
//
//  Created by Alexey Siginur on 18/08/2020.
//

import Foundation

public extension SMLogger.Configuration {
    
    static let `default` = SMLogger.Configuration(format: [
        .string("["),
        .severity,
        .string("]"),
        .spaces(untilLength: 8),
        
        .date(format: .init(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS")),
        .space,
        
        .filename(componentsCount: 1),
        .string(":"),
        .line,
        .space,
        
        .method,
        .space,
        
        .message
    ])
    
}

fileprivate extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
