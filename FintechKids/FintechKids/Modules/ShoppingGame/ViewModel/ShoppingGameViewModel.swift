//
//  ShoppingGameViewModel.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 01.04.2025.
//

import SwiftUI

class ShoppingGameViewModel: ObservableObject {
    @Published var selectedProducts: Set<CardGameRound> = []
    @Published var allProducts: [CardGameRound] = []
    @Published var pocket: Int = 1000
    @Published var progress: Double = 1.0
    @Published var isTimeUp: Bool = false
    @Published var showTimeUpSheet: Bool = false
    @Published var showOnboarding: Bool = false
    @Published var timePaused: Bool = false
    @Published var purchaseResult: PurchaseResult = .nothingBought
    @Published var totalSpent: Int = 0
    
    enum PurchaseResult {
        case nothingBought
        case parentsProud
        case parentsWorried
        case parentsNotProud
    }
    
    private var timer: DispatchSourceTimer?
    private var lastProgress: Double = 0
    private let storage = Storage()
    
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    init() {
        allProducts = storage.loadFromBundle()
    }
    
    func startTimer() {
        progress = 1.0
        isTimeUp = false
        showTimeUpSheet = false
        timePaused = false
        totalSpent = 0
        purchaseResult = .nothingBought
        selectedProducts.removeAll()
        pocket = 1000
        timer?.cancel()
        
        let queue = DispatchQueue(label: "fintechkids.timer", qos: .userInteractive)
        timer = DispatchSource.makeTimerSource(queue: queue)
        
        timer?.schedule(deadline: .now(), repeating: .milliseconds(100))
        timer?.setEventHandler { [weak self] in
            guard let self = self else { return }
            
            if !timePaused && !showOnboarding {
                if progress > 0 {
                    DispatchQueue.main.async {
                        self.progress -= 0.1 / 30
                    }
                } else {
                    DispatchQueue.main.async {
                        self.timer?.cancel()
                        self.timer = nil
                        self.isTimeUp = true
                        self.checkBudget()
                        self.showTimeUpSheet = true
                    }
                }
            }
        }
        
        timer?.resume()
    }
    
    private func checkBudget() {
        if selectedProducts.isEmpty {
            purchaseResult = .nothingBought
            return
        }
        
        let budgetLimit = 1000
        let allowedOverspending = Double(budgetLimit) * 0.1
        let totalSpent = budgetLimit - pocket
        
        if Double(totalSpent) <= (Double(budgetLimit) + allowedOverspending) {
            if Double(totalSpent) < Double(budgetLimit) * 0.5 {
                purchaseResult = .parentsWorried
            } else {
                purchaseResult = .parentsProud
            }
        } else {
            purchaseResult = .parentsNotProud
        }
    }
    
    func pauseTimer() {
        timePaused = true
        lastProgress = progress
    }
    
    func resumeTimer() {
        timePaused = false
        progress = lastProgress
    }
    
    func handleProductSelection(_ product: CardGameRound) {
        if selectedProducts.contains(product) {
            selectedProducts.remove(product)
            pocket += product.cost
            totalSpent -= product.cost
        } else {
            selectedProducts.insert(product)
            pocket -= product.cost
            totalSpent += product.cost
        }
    }
    
    func resetGame() {
        selectedProducts.removeAll()
        pocket = 1000
        totalSpent = 0
        showTimeUpSheet = false
        startTimer()
    }
}
