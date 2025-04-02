//
//  ChatViewModel.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI
import SwiftData

final class ChatViewModel: ObservableObject {
    
    @Published var isManagerProcessing: Bool = false
    @Published var messages: [Message] = []
    
    private let modelContext: ModelContext
    
    var lastMessage: Message?
    var chatService: ChatService
    
    init(chatService: ChatService, modelContext: ModelContext) {
        self.chatService = chatService
        self.modelContext = modelContext
        loadMessages()
    }
    
    func clearStorage() {
        
        do {
            try modelContext.delete(model: Message.self)
            resetMessages()
        } catch {
            print("Error of clearing storage: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createMessage(messageText: String) async {
        guard !messageText.isEmpty else { return }
        
        let newMessage = Message(title: messageText, isYours: true)
        modelContext.insert(newMessage)
        messages.append(newMessage)
        lastMessage = newMessage
        
        saveContext()
        
        let obtainMessageTask = Task {
            do {
                isManagerProcessing = true
                let settings = UserSettingsManager.shared
                let data = try await chatService.getFinickMessage(
                    promt: Prompt.message(
                        settings.userName,
                        settings.userAge,
                        settings.userHobbies,
                        messageText
                    )
                )
                let newMessage = Message(id: UUID(), title: data, isYours: false)
                
                modelContext.insert(newMessage)
                messages.append(newMessage)
                lastMessage = newMessage
                saveContext()
                self.isManagerProcessing = false
            } catch {
                alertMessage()
            }
        }
        
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
    
    func loadMessages() {
        do {
            messages = try modelContext.fetch(.init())
            if messages.isEmpty {
                resetMessages()
            }
            lastMessage = messages.max { $0.date < $1.date }
        } catch {
            print("Error loading messages: \(error.localizedDescription)")
        }
    }
    
    func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Error of saving data: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func alertMessage() {
        isManagerProcessing = false
        let alertMessage = Message(
            title: "Упс... Технические неполадки! Проверь интернет соединение и попробуй еще раз 🌐",
            isYours: false
        )
        modelContext.insert(alertMessage)
        messages.append(alertMessage)
        lastMessage = alertMessage
        saveContext()
    }
    
    func resetMessages() {
        messages = [Message(
            title:
                """
                Мяу-привет! 🐾
                Ой, как здорово, что мы встретились! Меня зовут Финик — я не просто кот, а твой личный финансовый помощник (и немножко волшебник)! ✨
                Я знаю всё о деньгах, сбережениях и даже секретных кошачьих трюках, чтобы стать настоящим мастером финансовой грамотности.

                Хочешь, я научу тебя, как превратить карманные деньги в настоящие сокровища? Или расскажу, как копить на то, что ты очень-очень хочешь? Мур-р-р, будет весело!
                """,
            isYours: false)
        ]
        lastMessage = messages[0]
    }
}
