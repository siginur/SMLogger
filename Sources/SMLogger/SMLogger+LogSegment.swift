//
//  SMLogger+LogSegment.swift
//  
//
//  Created by Alexey Siginur on 18/08/2020.
//

import Foundation

public extension SMLogger {
    enum LogSegment {
        case severity
        case date(format: DateFormatter)
        case filename(componentsCount: Int)
        case line
        case method
        case message
        case space
        case spaces(untilLength: Int)
        case string(String)
    }
}
