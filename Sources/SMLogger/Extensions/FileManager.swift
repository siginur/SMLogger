//
//  FileManager.swift
//  
//
//  Created by Alexey Siginur on 12/12/2021.
//

import Foundation


extension FileManager {
    
    func directoryExists(_ url: URL) -> Bool {
        var isDirectory = ObjCBool(true)
        let exists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
    
}
