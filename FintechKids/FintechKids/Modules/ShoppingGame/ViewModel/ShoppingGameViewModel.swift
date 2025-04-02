//
//  ShoppingGameViewModel.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 01.04.2025.
//

import SwiftUI

class ShoppingGameViewModel: ObservableObject {
    @Published var selectedProducts: Set<Product> = []
    @Published var pocket: Int = 1000
    @Published var progress: Double = 1.0
    @Published var isTimeUp: Bool = false
    @Published var showTimeUpSheet: Bool = false
    @Published var showOnboarding: Bool = false
    @Published var timePaused: Bool = false
    
    private var timer: Timer?
    private var lastProgress: Double = 0
    
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    func startTimer() {
        progress = 1.0
        isTimeUp = false
        showTimeUpSheet = false
        timePaused = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self else { return }
            
            if !timePaused && !showOnboarding {
                if progress > 0 {
                    progress -= 0.1 / 30
                } else {
                    timer?.invalidate()
                    timer = nil
                    isTimeUp = true
                    showTimeUpSheet = true
                }
            }
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
    
    func handleProductSelection(_ product: Product) {
        if selectedProducts.contains(product) {
            selectedProducts.remove(product)
            pocket += product.price
        } else {
            if pocket >= product.price {
                selectedProducts.insert(product)
                pocket -= product.price
            }
        }
    }
    
    func resetGame() {
        selectedProducts.removeAll()
        pocket = 1000
        showTimeUpSheet = false
        startTimer()
    }
}
