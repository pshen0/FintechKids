//
//  ChatViewModel.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

final class ChatViewModel: ObservableObject {
    
    @Published var data: [(Date, [Message])] = ChatDataMock.getMessagesByDay()
    @Published var isManagerProcessing: Bool = false
    @Published var lastMessage: Message?
    
    var chatService: ChatService
    
    init(chatService: ChatService) {
        self.chatService = chatService
        lastMessage = data.last?.1.last
    }
    
    @MainActor
    func createMessage(messageText: String) async {
        guard !messageText.isEmpty else { return }
        let newMessage = Message(id: UUID(), title: messageText, isYour: true),
            calendar = Calendar.current,
            today = calendar.startOfDay(for: newMessage.date)
        
        lastMessage = newMessage
        createMessage(calendar: calendar, currentDay: today, newMessage: newMessage)
        Task {
            do {
                isManagerProcessing = true
                // Mock
                let data = try await chatService.getFinickMessage(promt: Prompt.message("Данил", "19", "Программировать", messageText))
                let newMessage = Message(id: UUID(), title: data, isYour: false)
                
                createMessage(calendar: calendar, currentDay: today, newMessage: newMessage)
                lastMessage = newMessage
                self.isManagerProcessing = false
            } catch {
                // TODO: alert
            }
        }
    }
    
    func isSendingMessagesEnable(text: String) -> Bool {
        text.isEmpty || isManagerProcessing
    }
    
    deinit {
        // TODO: Save data to storage
        print("saved")
    }
}

private extension ChatViewModel {
    
    func createMessage(calendar: Calendar, currentDay: Date, newMessage: Message) {
        DispatchQueue.main.async {
            if let index = self.data.firstIndex(where: { calendar.isDate($0.0, inSameDayAs: currentDay) }) {
                self.data[index].1.append(newMessage)
            } else {
                self.data.append((currentDay, [newMessage]))
            }
        }
    }
}
