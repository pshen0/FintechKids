//
//  OnboardsViewModel.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 02.04.2025.
//

import Foundation
import SwiftUI

class OnboardsViewModel: ObservableObject {
    @Published var progress: Double = 1.0
    @Published var selectedProducts: Set<Product> = []
    @Published var currentSelectionIndex: Int = 0
    @Published var isTimeUp: Bool = false
    
    let progressTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let selectionTimer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    var totalSpend: Int {
        selectedProducts.reduce(0) { $0 + $1.price }
    }
    
    func handleProgressTimer() {
        if progress > 0 {
            progress -= 0.1 / 30
        }
    }
    
    func handleProductSelection() {
        if currentSelectionIndex < Product.sampleProducts.count {
            selectedProducts.insert(Product.sampleProducts[currentSelectionIndex])
            currentSelectionIndex += 1
        } else {
            selectedProducts.removeAll()
            currentSelectionIndex = 0
        }
        
    }
    
    func resetProgress() {
        progress = 1.0
    }
}
