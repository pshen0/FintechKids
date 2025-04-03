//
//  ProductGridGame.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 01.04.2025.
//

import SwiftUI

struct ProductGridGame: View {
    let columns: [GridItem]
    let allProducts: [CardGameRound]
    let selectedProducts: Set<CardGameRound>
    let isTimeUp: Bool
    let onProductSelected: (CardGameRound) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(allProducts, id: \.self) { product in
                    ProductItemView(product: product, isSelected: selectedProducts.contains(product), isTimeUp: isTimeUp) {
                        onProductSelected(product)
                    }
                }
            }
            .padding(10)
        }
    }
}
