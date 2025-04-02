//
//  CardGameViewModel.swift
//  FintechKids
//
//  Created by Margarita Usova on 26.03.2025.
//

import Foundation
import SwiftUI

final class CardGameViewModel: ObservableObject {
    @Published var userInput = ""
    @Published var feedback = ""
    @Published var attempts = 3
    @Published var showNext = false
    @Published var wrongAnswer = false
    @Published private(set) var screen: ScreenData
    @ObservedObject var screenFactory: ScreenFactory
    @Published var isCorrect = false
    private var currentRound = 0
    
    init(screen: Screen, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.screen = screenFactory.createScreen(ofType: screen)
    }

    
    var model: CardGameRound {
        switch screen {
        case .cardsGame(let gameRounds):
            return gameRounds[currentRound]
        }
    }
    
    var roundsCount: Int {
        switch screen {
        case .cardsGame(let gameRounds):
            return gameRounds.count
        }
    }
    
    func checkPrice() -> Bool {
        guard let guessedPrice = Int(userInput) else { return false }
        if attempts > 0 {
            attempts -= 1
            feedback = getFeedback(for: guessedPrice)
        }
        
        let isCorrect = guessedPrice == model.cost
        if isCorrect || attempts == 0 || isCloseEnough(guessedPrice) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.nextCard()
            }
        }
        
        self.isCorrect = isCorrect
        return isCorrect
    }
    
    private func getFeedback(for guessedPrice: Int) -> String {
        switch guessedPrice {
        case model.cost:
            return "Правильно! 🎉"
        case let price where isCloseEnough(price):
            return "Почти правильно! 🎉 Верный ответ: \(model.cost)"
        case let price where price != model.cost && attempts == 0:
            wrongAnswer.toggle()
            return "Попытки закончились! Верный ответ: \(model.cost)"
        case let price where price > model.cost:
            wrongAnswer.toggle()
            return "Слишком дорого! Попробуй снова."
        case let price where price < model.cost:
            wrongAnswer.toggle()
            return "Слишком дешево! Попробуй снова."
        default:
            return "Неправильно! Верный ответ: \(model.cost)"
        }
    }
    
    private func isCloseEnough(_ guessedPrice: Int) -> Bool {
        let lowerBound = Int(Double(model.cost) * 0.9)
        let upperBound = Int(Double(model.cost) * 1.1)
        return guessedPrice >= lowerBound && guessedPrice <= upperBound
    }
    
    func nextCard() {
        attempts = 3
        userInput = ""
        feedback = ""
        if currentRound >= roundsCount - 1{
            currentRound = 0
        } else {
            currentRound += 1
        }
        showNext.toggle()
    }
}
