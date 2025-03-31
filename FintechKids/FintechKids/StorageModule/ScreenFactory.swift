//
//  ScreenFactory.swift
//  FintechKids
//
//  Created by Margarita Usova on 28.03.2025.
//

import Foundation

final class ScreenFactory: ObservableObject {
    private static var cachedData: [Screen: ScreenData] = [:]
    
    private static var analyticsData: [CardGameRound] {
        let storage = Storage()
        return storage.loadFromBundle()
    }
    
    static func createScreen(ofType screenType: Screen) -> ScreenData {
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
            newData = .cardsGame([])
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
}

enum Screen {
    case analytics
    case goals
    case chat
    case cardsGame
    case settings
}
