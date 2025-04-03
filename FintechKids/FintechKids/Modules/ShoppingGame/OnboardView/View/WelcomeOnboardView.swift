//
//  WelcomeOnboardView.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 02.04.2025.
//

import SwiftUI

struct WelcomeOnboardView: View {
    @Binding var showInstructions: Bool
    let onReturnToGame: () -> Void
    let userDefaults = UserDefaults.standard
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gamecontroller.fill")
                .imageScale(.large)
                .font(.system(size: 60))
                .foregroundStyle(.text)
            
            Text("Добро пожаловать!")
                .font(Font.custom(Fonts.deledda, size: 28))
                .bold()
                .foregroundStyle(.text)

            Text("Привет \(String(describing: userDefaults.value(forKey: "userName")))! Прокрути вправо, чтобы узнать больше о правилах и управлении")
                .font(Font.custom(Fonts.deledda, size: 18))
                .foregroundStyle(.text.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
                .lineSpacing(4)
        }
        .padding()
    }
}
