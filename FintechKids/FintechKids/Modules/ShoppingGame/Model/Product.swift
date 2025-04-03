//
//  Product.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 01.04.2025.
//

import Foundation
import SwiftUI

struct Product: Hashable {
    let color: Color
    let name: String
    let price: Int
    
    static var sampleProducts: [Product] = [
        Product(color: .highlightedBackground, name: "Красный", price: 100),
        Product(color: .highlightedBackground, name: "Синий", price: 150),
        Product(color: .highlightedBackground, name: "Зеленый", price: 200),
        Product(color: .highlightedBackground, name: "Желтый", price: 80),
        Product(color: .highlightedBackground, name: "Оранжевый", price: 120),
        Product(color: .highlightedBackground, name: "Фиолетовый", price: 180),
        Product(color: .highlightedBackground, name: "Розовый", price: 90),
        Product(color: .highlightedBackground, name: "Мятный", price: 160),
        Product(color: .highlightedBackground, name: "Индиго", price: 140),
        Product(color: .highlightedBackground, name: "Бирюзовый", price: 110)
    ]
}
