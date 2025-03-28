//
//  CardGameViewModel.swift
//  FintechKids
//
//  Created by Yandex Event on 26.03.2025.
//

import Foundation

final class CardGameViewModel: ObservableObject {
    var model: CardGameModel
    @Published var userInput = ""
    @Published var feedback = ""
    @Published var attempts = 3
    
    init(model: CardGameModel) {
        self.model = model
    }
    
    func checkPrice() {
        guard let guessedPrice = Int(userInput) else { return }
        
        if attempts > 0 {
            attempts -= 1
            feedback = getFeedback(for: guessedPrice)
        }
    }

    private func getFeedback(for guessedPrice: Int) -> String {
        switch guessedPrice {
        case model.cost:
            return "Правильно! 🎉"
        case let price where price > model.cost:
            return "Слишком дорого! Попробуй снова."
        case let price where price < model.cost:
            return "Слишком дешево! Попробуй снова."
        default:
            return "Неправильно! Верный ответ: \(model.cost)"
        }
    }

    
}
