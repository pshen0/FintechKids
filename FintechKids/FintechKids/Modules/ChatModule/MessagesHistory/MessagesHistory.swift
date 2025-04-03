//
//  MessagesHistory.swift
//  FintechKids
//
//  Created by Данил Забинский on 03.04.2025.
//

import Foundation

struct MessagesHistory {
    
    static var history: String = "Мы с тобой уже общались о:"
    
    static func updateHistory(isYours: Bool, message: String) {
        history += isYours ? "Я тебя справивал: \(message)" : "Ты мне отвечал: \(message)"
    }
}
