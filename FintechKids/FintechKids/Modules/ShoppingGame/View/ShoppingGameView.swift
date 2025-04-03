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
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                        allProducts: viewModel.allProducts,
                        selectedProducts: viewModel.selectedProducts,
                        isTimeUp: viewModel.isTimeUp,
                        onProductSelected: viewModel.handleProductSelection
                    )
                }
                .padding(.top, 16)
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
                .onDisappear {
                    viewModel.resumeTimer()
                }
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

#Preview {
    ShoppingGameView(viewModel: ShoppingGameViewModel())
}

