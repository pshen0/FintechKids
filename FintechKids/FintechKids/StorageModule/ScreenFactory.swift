//
//  ScreenFactory.swift
//  FintechKids
//
//  Created by Margarita Usova on 28.03.2025.
//

import Foundation
import SwiftData

final class ScreenFactory: ObservableObject {
    private var cachedData: [Screen: ScreenData] = [:]
    
    /// Chat screen data
    private lazy var chatService: ChatService = ChatService()
    private lazy var container: ModelContainer = {
        do {
            return try ModelContainer(for: Message.self)
        } catch {
            fatalError("Error of creating container")
        }
    }()
    @MainActor private lazy var context: ModelContext = {
        container.mainContext
    }()
    
    /// Analytics screen data
    lazy private var analyticsData: [CardGameRound] = {
        let storage = Storage()
        return storage.loadFromBundle()
    }()
    
    @MainActor func createScreen(ofType screenType: Screen) -> ScreenData {
        if let data = cachedData[screenType] {
            return data
        }
        
        let newData: ScreenData
        switch screenType {
        case .analytics:
            newData = .cardsGame(analyticsData)
        case .cardsGame:
            newData = .cardsGame([])
        case .chat:
            let chatViewModel = ChatViewModel(chatService: chatService, modelContext: self.context)
            newData = .chatScreen(chatViewModel)
        case .goals:
            newData = .cardsGame([])
        case .settings:
            newData = .cardsGame([])
        }
        
        cachedData[screenType] = newData
        return newData
    }
}

enum ScreenData {
    case cardsGame([CardGameRound])
    case chatScreen(ChatViewModel)
}

enum Screen {
    case analytics
    case goals
    case chat
    case cardsGame
    case settings
}
