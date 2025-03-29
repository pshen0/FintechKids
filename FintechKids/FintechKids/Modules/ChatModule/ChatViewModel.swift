//
//  ChatViewModel.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

final class ChatViewModel: ObservableObject {
    
    @Published var data: [(Date, [Message])] = ChatDataMock.getMessagesByDay()
    
    func createMessage(text: inout String) {
        let newMessage = Message(title: text, isYour: true)
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: newMessage.date)
        
        if let index = data.firstIndex(where: { calendar.isDate($0.0, inSameDayAs: today) }) {
            data[index].1.append(newMessage)
        } else {
            data.append((today, [newMessage]))
        }
        
        text = ""
    }
    
    func getCarefulLast() -> Message? {
        guard let lastGroup = data.last, let lastMessage = lastGroup.1.last else {
            return nil
        }
        return lastMessage
    }
    
    func getForceLast() -> Message {
        return data.last!.1.last!
    }
}
