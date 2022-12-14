//
//  Logs.swift
//  JetDevsHomeWork
//
//  Created by Hemang Solanki on 14/12/22.
//

import Foundation

class Logs {
    static var allowLogs: Bool = true
    static func printLogs(message: String, items: Any? = nil) {
        if allowLogs == true {
            print(message, items ?? "")
        }
    }
}
