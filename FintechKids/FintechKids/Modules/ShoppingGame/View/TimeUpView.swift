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
    let purchaseResult: ShoppingGameViewModel.PurchaseResult
    let onRepeat: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    private enum Constants {
        static var spacingStack: CGFloat = 24
        static var smallSpacingStack: CGFloat = 12
        static var productImageSize: CGFloat = 80
        static var clockSize: CGFloat = 60
        static var cornerRadius: CGFloat = 16
        static var productCornerRadius: CGFloat = 12
        
        static var buttonWidth: CGFloat {
            UIScreen.main.bounds.width * 0.4
        }
        
        static var buttonHeight: CGFloat {
            UIScreen.main.bounds.height * 0.05
        }
    }
    
    private var gradient: some View {
        LinearGradient (
            gradient: Gradient(stops: [
                .init(color: Color.highlightedBackground, location: 0.2),
                .init(color: Color.background, location: 0.6),
            ]),
            startPoint: .top,
            endPoint: .bottom
        ).ignoresSafeArea()
    }
    
    private var totalSpend: Int {
        selectedProducts.reduce(0) { $0 + $1.cost }
    }
    
    private var headerView: some View {
        VStack(spacing: Constants.smallSpacingStack) {
            Image(systemName: "clock.fill")
                .font(.system(size: Constants.clockSize))
                .foregroundStyle(Color.background)
                .shadow(color: Color.background.opacity(0.3), radius: 10)
            
            Text("Время вышло")
                .font(Font.custom(Fonts.deledda, size: 32))
                .bold()
                .foregroundStyle(Color.background)
            
            switch purchaseResult {
            case .nothingBought:
                Text("Родители переживают за тебя")
                    .font(Font.custom(Fonts.deledda, size: 24))
                    .foregroundStyle(Color.text)
                Text("Ты ничего не купил! Родители волнуются, что ты не поел. В следующий раз постарайся выбрать хотя бы несколько продуктов")
                    .font(Font.custom(Fonts.deledda, size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.text.opacity(0.9))
                
            case .parentsProud:
                Text("Родители гордятся тобой!")
                    .font(Font.custom(Fonts.deledda, size: 24))
                    .foregroundStyle(Color.text)
                Text("Ты отлично справился с покупками! Ты уложился в бюджет и можешь оставить сдачу на карманные расходы!")
                    .font(Font.custom(Fonts.deledda, size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.text.opacity(0.9))
                
            case .parentsWorried:
                Text("Родители волнуются")
                    .font(Font.custom(Fonts.deledda, size: 24))
                    .foregroundStyle(Color.text.opacity(0.9))
                Text("Ты потратил слишком мало денег. Родители переживают, что тебе не хватит еды. В следующий раз постарайся купить больше продуктов")
                    .font(Font.custom(Fonts.deledda, size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.text.opacity(0.9))
                
            case .parentsNotProud:
                Text("Родители недовольны тобой")
                    .font(Font.custom(Fonts.deledda, size: 24))
                    .foregroundStyle(Color.background)
                Text("Ты потратил слишком много денег. В следующий раз постарайся уложиться в бюджет!")
                    .font(Font.custom(Fonts.deledda, size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.text.opacity(0.9))
            }
        }
        .padding()
    }
    
    private func productRow(for product: CardGameRound) -> some View {
        HStack(spacing: Constants.smallSpacingStack) {
            Image(product.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: Constants.productImageSize, height: Constants.productImageSize)
                .cornerRadius(Constants.productCornerRadius)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(Font.custom(Fonts.deledda, size: 16))
                    .fontWeight(.medium)
                Text("\(product.cost)р")
                    .font(Font.custom(Fonts.deledda, size: 14))
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
    
    private var productList: some View {
        VStack(alignment: .leading, spacing: Constants.smallSpacingStack) {
            Text("Выбранные товары:")
                .font(Font.custom(Fonts.deledda, size: 20))
                .padding(.horizontal)
            
            ForEach(Array(selectedProducts), id: \.self) { product in
                productRow(for: product)
            }
            
            Divider()
                .padding(.vertical, 8)
            
            VStack(spacing: Constants.smallSpacingStack) {
                HStack {
                    Text("Осталось на балансе:")
                        .font(Font.custom(Fonts.deledda, size: 16))
                    Spacer()
                    Text("\(pocket)р")
                        .font(Font.custom(Fonts.deledda, size: 16))
                        .bold()
                        .foregroundStyle(.green)
                }
                
                HStack {
                    Text("Потрачено:")
                        .font(Font.custom(Fonts.deledda, size: 16))
                    Spacer()
                    Text("\(totalSpend)р")
                        .font(Font.custom(Fonts.deledda, size: 16))
                        .bold()
                        .foregroundStyle(.red)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var buttonsContainer: some View {
        HStack(spacing: Constants.spacingStack) {
            TransparentButton(
                title: "Закрыть",
                fontSize: 16,
                width: UIScreen.main.bounds.width * 0.35,
                height: 50
            ) {
                dismiss()
                NotificationCenter.default.post(name: NSNotification.Name("DismissShoppingGame"), object: nil)
            }
            
            GradientButton(
                title: "Повторить",
                fontSize: 16,
                width: UIScreen.main.bounds.width * 0.35,
                height: 50
            ) {
                onRepeat()
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    var body: some View {
        ZStack {
            gradient
            
            ScrollView {
                VStack(spacing: Constants.spacingStack) {
                    headerView
                    productList
                    buttonsContainer
                }
                .padding()
            }
        }
        .interactiveDismissDisabled()
    }
}
