//
//  Transaction.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 28.03.2025.
//

import Foundation

struct Transaction: Codable, Identifiable {
    let id = UUID()
    let date: Date
    let amount: Double
    let category: String
    let description: String
    
    init(date: Date, amount: Double, category: String, description: String = "") {
        self.date = date
        self.amount = amount
        self.category = category
        self.description = description
    }
}
