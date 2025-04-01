//
//  ShoppingGameView.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 01.04.2025.
//

import Foundation
import SwiftUI

struct ShoppingGameView: View {
    @ObservedObject private var viewModel = ShoppingGameViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            WalletView(
                pocket: viewModel.pocket,
                onInfoTapped: { viewModel.showOnboarding = true }
            )
            TimerView(progress: viewModel.progress)
            
            ProductGridGame(
                columns: viewModel.columns,
                selectedProducts: viewModel.selectedProducts,
                isTimeUp: viewModel.isTimeUp,
                onProductSelected: viewModel.handleProductSelection
            )
        }
        .onAppear {
            viewModel.startTimer()
        }
        
        .sheet(isPresented: $viewModel.showTimeUpSheet) {
            TimeUpView(
                selectedProducts: viewModel.selectedProducts,
                pocket: viewModel.pocket,
                onRepeat: viewModel.resetGame)
        }
    }
}

#Preview {
    ShoppingGameView()
}
