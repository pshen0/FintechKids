//
//  ChatViewModel.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

struct Message {
    
    let title: String
    let date = Date()
}

class ChatViewModel {
    
    func getMockData() -> [Message] {
        [
            Message(title: "1"),
            Message(title: "6"),
            Message(title: "2"),
            Message(title: "3"),
            Message(title: "4"),
            Message(title: "5"),
        ]
    }
}
