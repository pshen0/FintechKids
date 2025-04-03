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
    @Published var wrongAnswer = false
    @Published private(set) var screen: ScreenData
    @ObservedObject var screenFactory: ScreenFactory
    @Published var showSuccessAnimation = false
    @Published var showErrorBackground = false
    @Published var showGameOver = false
    @Published var score = 0
    @Published var currentRound = 0
    @Published var flipp = false
    
    private var allCards: [CardGameRound] = []
    private var currentRoundCards: [CardGameRound] = []
    var currentCardIndex = 0
    
    init(screen: Screen, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.screen = screenFactory.createScreen(ofType: screen)
        setupGame()
    }
    
    func setupGame() {
        resetGameState()
        if case .cardsGame(let gameRounds) = screen {
            var shuffledCards = gameRounds
            shuffledCards.shuffle()
            
            var rounds: [[CardGameRound]] = []
            for i in stride(from: 0, to: shuffledCards.count, by: 5) {
                let endIndex = min(i + 5, shuffledCards.count)
                let round = Array(shuffledCards[i..<endIndex])
                rounds.append(round)
            }
            
            rounds = rounds.map { $0.shuffled() }
            
            allCards = rounds.flatMap { $0 }
            startNewRound()
        }
    }
    
    private func resetGameState() {
        score = 0
        currentRound = 0
        showGameOver = false
        showSuccessAnimation = false
        showErrorBackground = false
        feedback = ""
        userInput = ""
        attempts = 3
        flipp = false
        wrongAnswer = false
    }
    
    private func startNewRound() {
        let startIndex = currentRound * 5
        guard startIndex < allCards.count else { showGameOver = true; return }
        
        let roundCards = Array(allCards[startIndex..<min(startIndex + 5, allCards.count)])
        currentRoundCards = roundCards.shuffled()
        resetRoundState()
    }
    
    private func resetRoundState() {
        currentCardIndex = 0
        attempts = 3
        userInput = ""
        feedback = ""
        flipp = false
        wrongAnswer = false
    }
    
    var model: CardGameRound {
        currentRoundCards[safe: currentCardIndex] ?? CardGameRound(name: "", imageName: "", cost: 0)
    }
    
    func checkPrice() {
        let guessedPrice = Int(userInput) ?? 0
        if isCloseEnough(guessedPrice) {
            handleCorrectGuess()
        } else {
            handleIncorrectGuess(guessedPrice)
        }
    }
    
    private func handleCorrectGuess() {
        score += attempts
        withAnimation(.easeInOut(duration: 0.3)) {
            showSuccessAnimation = true
            showErrorBackground = false
            feedback = ""
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeInOut(duration: 0.3)) {
                self.showSuccessAnimation = false
                self.nextCard()
            }
        }
    }
    
    private func handleIncorrectGuess(_ guessedPrice: Int) {
        guard attempts > 0 else { return }
        attempts -= 1
        
        withAnimation(.easeInOut(duration: 0.3)) {
            feedback = getFeedback(for: guessedPrice)
            userInput = ""
            showErrorBackground = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                self.showErrorBackground = false
            }
        }
        
        if attempts == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.flipp = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.nextCard()
                    }
                }
            }
        }
    }
    
    func nextCard() {
           currentCardIndex += 1
           
           if currentCardIndex >= currentRoundCards.count {
               currentRound += 1
               if currentRound >= 3 {
                   showGameOver = true
               } else {
                   startNewRound()
               }
           } else {
               attempts = 3
               userInput = ""
               feedback = ""
               flipp = false
               wrongAnswer = false
               showErrorBackground = false
           }
       }
    
    private func getFeedback(for guessedPrice: Int) -> String {
        switch guessedPrice {
        case let price where isCloseEnough(price):
            return "Почти правильно! 🎉 Верный ответ: \(model.cost)"
        case let price where price > model.cost:
            wrongAnswer = true
            return "Слишком дорого! Попробуй снова."
        default:
            wrongAnswer = true
            return "Слишком дешево! Попробуй снова."
        }
    }
    
    private func isCloseEnough(_ guessedPrice: Int) -> Bool {
        let range = Int(Double(model.cost) * 0.7)...Int(Double(model.cost) * 1.3)
        return range.contains(guessedPrice)
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
