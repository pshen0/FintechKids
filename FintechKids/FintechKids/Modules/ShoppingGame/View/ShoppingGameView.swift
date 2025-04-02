//
//  ShoppingGameView.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 01.04.2025.
//

import Foundation
import SwiftUI

struct ShoppingGameView: View {
    @ObservedObject var viewModel: ShoppingGameViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                WalletView(
                    pocket: viewModel.pocket,
                    onInfoTapped: {
                        viewModel.pauseTimer()
                        viewModel.showOnboarding = true
                    }
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
            
            .sheet(isPresented: $viewModel.showOnboarding) {
                OnboardingView(
                    showInstructions: $viewModel.showOnboarding,
                    onReturnToGame: {
                        viewModel.showOnboarding = false
                        viewModel.resumeTimer()
                    }
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        DismissButtonLabel()
                    }
                }
            }
        }
        
    }
}

