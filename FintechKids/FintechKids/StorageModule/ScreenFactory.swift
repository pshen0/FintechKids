//
//  ScreenFactory.swift
//  FintechKids
//
//  Created by Margarita Usova on 28.03.2025.
//

import Foundation

final class ScreenFactory: ObservableObject {
    private static var cachedData: [Screens: ScreenData] = [:]
    
    static func createScreen(for screen: Screens) -> ScreenData {
        if let data = cachedData[screen] {
            return data
        }
        
        let newData: ScreenData
        switch screen {
        case .Analytics:
            newData = .CardsGame([
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
        default:
            newData = .CardsGame([])
        }
        
        cachedData[screen] = newData
        return newData
    }
}

enum ScreenData {
    case CardsGame([CardGameRound])
}

enum Screens {
    case Analytics
    case Goals
    case Chat
    case CardsGame
    case Settings
}
