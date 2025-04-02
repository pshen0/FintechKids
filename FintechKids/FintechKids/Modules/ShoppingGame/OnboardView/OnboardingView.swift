//
//  OnboardindView.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 02.04.2025.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var showInstructions: Bool
    let onReturnToGame: () -> Void
    
    var body: some View {
        TabView {
            WelcomeOnboardView(showInstructions: $showInstructions, onReturnToGame: onReturnToGame)
            
            BotOnboardView()
            
            TimerOnboardView(showInstructions: $showInstructions, onReturnToGame: onReturnToGame)
            
            StartOnboardView(showInstructions: $showInstructions, onReturnToGame: onReturnToGame)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}
