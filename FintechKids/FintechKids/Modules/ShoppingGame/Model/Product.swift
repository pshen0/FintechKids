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
        Product(color: .red, name: "Красный", price: 100),
        Product(color: .blue, name: "Синий", price: 150),
        Product(color: .green, name: "Зеленый", price: 200),
        Product(color: .yellow, name: "Желтый", price: 80),
        Product(color: .orange, name: "Оранжевый", price: 120),
        Product(color: .purple, name: "Фиолетовый", price: 180),
        Product(color: .pink, name: "Розовый", price: 90),
        Product(color: .mint, name: "Мятный", price: 160),
        Product(color: .indigo, name: "Индиго", price: 140),
        Product(color: .teal, name: "Бирюзовый", price: 110)
    ]
}
