//
//  TimeUpView.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 01.04.2025.
//

import SwiftUI

struct TimeUpView: View {
    let selectedProducts: Set<CardGameRound>
    let pocket: Int
    let onRepeat: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    private enum Constants {
        static var spacingStack: CGFloat = 20
        static var smallSpacingStack: CGFloat = 10
        static var circleSize: CGFloat = 20
        static var clockSize: CGFloat = 60
    }
    
    private var totalSpend: Int {
        selectedProducts.reduce(0) { $0 + $1.cost }
    }
    
    private var clockIcon: some View {
        Image(systemName: "clock.fill")
            .font(.system(size: Constants.clockSize))
            .foregroundStyle(.red)
    }
    
    private var titleText: some View {
        Text("Время вышло")
            .font(.title)
            .bold()
    }
    
    private func productCircle(for product: CardGameRound) -> some View {
        Circle()
            .fill(Color.blue)
            .frame(width: Constants.circleSize, height: Constants.circleSize)
    }
    
    private func productRow(for product: CardGameRound) -> some View {
        HStack {
            productCircle(for: product)
            Text(product.name)
            Spacer()
            Text("\(product.cost)р")
                .foregroundStyle(.gray)
        }
    }
    
    private var productList: some View {
        VStack(alignment: .leading, spacing: Constants.smallSpacingStack) {
            Text("Выбранные товары:")
                .font(.headline)
            
            ForEach(Array(selectedProducts), id: \.self) { product in
                productRow(for: product)
            }
            
            Divider()
            
            HStack {
                Text("Осталось на балансе:")
                    .font(.headline)
                Spacer()
                Text("\(pocket)р")
                    .foregroundStyle(.green)
            }
            
            HStack {
                Text("Потрачено:")
                    .font(.headline)
                Spacer()
                Text("\(totalSpend)р")
                    .foregroundStyle(.red)
            }
        }
        .padding()
    }
    
    private var buttonsContainer: some View {
        HStack(spacing: Constants.spacingStack) {
            Button("Закрыть") {
                dismiss()
            }
            .buttonStyle(.bordered)
            
            Button("Повторить") {
                onRepeat()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.top)
    }
    
    var body: some View {
        VStack(spacing: Constants.spacingStack) {
            clockIcon
            titleText
            productList
            buttonsContainer
        }
        .padding()
    }
}
