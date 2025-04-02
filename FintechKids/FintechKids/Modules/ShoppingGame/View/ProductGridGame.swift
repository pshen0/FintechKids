//
//  ProductGridGame.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 01.04.2025.
//

import SwiftUI

struct ProductGridGame: View {
    let columns: [GridItem]
    let selectedProducts: Set<Product>
    let isTimeUp: Bool
    let onProductSelected: (Product) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(Product.sampleProducts, id: \.self) { product in
                    ProductItemView(product: product, isSelected: selectedProducts.contains(product), isTimeUp: isTimeUp) {
                        onProductSelected(product)
                    }
                }
            }
            .padding(10)
        }
    }
}
 
