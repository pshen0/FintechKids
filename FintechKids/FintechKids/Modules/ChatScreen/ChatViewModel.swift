//
//  ChatViewModel.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

final class ChatViewModel: ObservableObject {
    
    @Published var data: [Message] = ChatDataMock.default
    
    func createMessage(text: inout String) -> UUID {
        let message = Message(title: text, isYour: true)
        data.append(message)
        text = ""
        return message.id
    }
}
