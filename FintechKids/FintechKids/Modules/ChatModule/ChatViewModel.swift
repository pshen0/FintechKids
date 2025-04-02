//
//  ChatViewModel.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

final class ChatViewModel: ObservableObject {
    
    private(set) var data: [(Date, [Message])] = ChatDataMock.getMessagesByDay() // 1?
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
        let newMessage = Message(id: UUID(), title: messageText, isYours: true)
        lastMessage = newMessage
        createMessage(newMessage: newMessage)
        
        let obtainMessageTask = Task {
            do {
                isManagerProcessing = true
                 let data = try await chatService.getFinickMessage(promt: Prompt.message("Данил", "19", "Программировать", messageText))
                 let newMessage = Message(id: UUID(), title: data, isYours: false)
                 createMessage(newMessage: newMessage)
                 lastMessage = newMessage
                 self.isManagerProcessing = false
            } catch {
                alertMessage()
            }
        }
        /// Если думает больше 15 секунд - свапаем запрос
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            if !obtainMessageTask.isCancelled && self.isManagerProcessing {
                obtainMessageTask.cancel()
                self.isManagerProcessing = false
                self.alertMessage()
            }
        }
    }
    
    func isSendingMessagesEnable(text: String) -> Bool {
        text.isEmpty || isManagerProcessing
    }
}

private extension ChatViewModel {
    
    @MainActor
    func createMessage(newMessage: Message) {
        let date = Calendar.current.startOfDay(for: newMessage.date)
        if let index = self.data.firstIndex(where: { Calendar.current.isDate($0.0, inSameDayAs: date) }) {
            self.data[index].1.append(newMessage)
        } else {
            self.data.append((date, [newMessage]))
        }
    }
    
    @MainActor
    func alertMessage() {
        isManagerProcessing = false
        let alertMessage = Message(id: UUID(),
                title: "Упс... Технические неполадки! Проверь интернет соединение и попробуй еще раз 🌐",
                isYours: false)
        createMessage(newMessage: alertMessage)
        lastMessage = alertMessage
    }
}
