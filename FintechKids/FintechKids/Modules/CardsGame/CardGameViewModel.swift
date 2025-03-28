//
//  CardGameViewModel.swift
//  FintechKids
//
//  Created by Margarita Usova on 26.03.2025.
//

import Foundation

final class CardGameViewModel: ObservableObject {
    @Published var userInput = ""
    @Published var feedback = ""
    @Published var attempts = 3
    @Published var showNext = false
    private let rounds: [CardGameRound]
    private var currentRound = 0
    
    init(rounds: [CardGameRound]) {
        self.rounds = rounds.shuffled()
    }
    
    var model: CardGameRound {
        rounds[currentRound]
    }
    
    func checkPrice() {
        guard let guessedPrice = Int(userInput) else { return }
        if attempts > 0 {
            attempts -= 1
            feedback = getFeedback(for: guessedPrice)
        }
    }
    
    private func getFeedback(for guessedPrice: Int) -> String {
        if guessedPrice == model.cost || attempts == 0 || isCloseEnough(guessedPrice) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.nextCard()
            }
        }
        switch guessedPrice {
        case model.cost:
            return "Правильно! 🎉"
        case let price where isCloseEnough(price):
            return "Почти правильно! 🎉 Верный ответ: \(model.cost)"
        case let price where price != model.cost && attempts == 0:
            return "Попытки закончились! Верный ответ: \(model.cost)"
        case let price where price > model.cost:
            return "Слишком дорого! Попробуй снова."
        case let price where price < model.cost:
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
        if currentRound >= rounds.count - 1{
            currentRound = 0
        } else {
            currentRound += 1
        }
        showNext.toggle()
    }
}
