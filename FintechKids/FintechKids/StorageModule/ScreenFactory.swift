//
//  ScreenFactory.swift
//  FintechKids
//
//  Created by Margarita Usova on 28.03.2025.
//

import Foundation

final class ScreenFactory: ObservableObject {
    private static var cachedData: [Screen: ScreenData] = [:]
    
    static func createScreen(ofType screenType: Screen) -> ScreenData {
        if let data = cachedData[screenType] {
            return data
        }
        
        let newData: ScreenData
        switch screenType {
        case .analytics:
            newData = .cardsGame([
                CardGameRound(
                    name: "батон белого хлеба",
                    imageName: "BreadImage",
                    cost: 80
                ),
                CardGameRound(
                    name: "мороженое",
                    imageName: "IceCreamImage",
                    cost: 100
                ),
                CardGameRound(
                    name: "ветка бананов",
                    imageName: "BreadImage",
                    cost: 180
                ),
                CardGameRound(
                    name: "бутылка молока",
                    imageName: "BreadImage",
                    cost: 90
                )
            ])
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
