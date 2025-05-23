//
//  BotOnboardView.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 02.04.2025.
//

import SwiftUI

struct BotOnboardView: View {
    @StateObject private var viewModel = OnboardsViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            walletSection
            instructionSection
            productGrid
        }
        .onReceive(viewModel.selectionTimer) { _ in
            viewModel.handleProductSelection()
        }
    }
    
    private var walletSection: some View {
        WalletView(
            pocket: 1000 - viewModel.totalSpend,
            onInfoTapped: { }
        )
        .padding(.top, 20)
    }
    
    private var instructionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Родители дали тебе 1000 рублей на еду сегодня")
                .font(Font.custom(Fonts.deledda, size: 18))
                .fontWeight(.medium)
                .foregroundStyle(.text)
            
            Text("Потрать деньги с умом! Если ты потратишь больше, чем у тебя есть, родители будут недовольны. Выбирай продукты так, чтобы хватило на день")
                .font(Font.custom(Fonts.deledda, size: 16))
                .foregroundStyle(.text.opacity(0.9))
                .lineSpacing(4)
        }
        .padding(.horizontal)
    }
    
    private var productGrid: some View {
        ProductGridGame(
            columns: viewModel.columns,
            allProducts: viewModel.allProducts,
            selectedProducts: viewModel.selectedProducts,
            isTimeUp: viewModel.isTimeUp,
            onProductSelected: { _ in }
        )
    }
}
