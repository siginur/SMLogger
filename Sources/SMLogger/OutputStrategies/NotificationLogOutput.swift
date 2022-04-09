//
//  NotificationLogOutput.swift
//  
//
//  Created by Alexey Siginur on 15/12/2021.
//

import Foundation

open class NotificationLogOutput: LogOutput {
    
    public let notificationCenter: NotificationCenter
    public let notificationName: Notification.Name
    
    public init(notificationCenter: NotificationCenter = NotificationCenter.default, notificationName: Notification.Name) {
        self.notificationCenter = notificationCenter
        self.notificationName = notificationName
    }
    
    public final func write(_ log: String) {
        notificationCenter.post(name: notificationName, object: log)
    }
}
