//
//  StartOnboardView.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 02.04.2025.
//

import SwiftUI

struct StartOnboardView: View {
    @Binding var showInstructions: Bool
    let onReturnToGame: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "flag.filled.and.flag.crossed")
                .imageScale(.large)
                .font(.system(size: 60))
                .foregroundStyle(.text)
            
            Text("Приступим")
                .font(Font.custom(Fonts.deledda, size: 28))
                .bold()
                .foregroundStyle(.text)
            
            Text("Нажми на кнопку чтобы начать игру!")
                .font(Font.custom(Fonts.deledda, size: 18))
                .foregroundStyle(.text.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
                .lineSpacing(4)
            
            GradientButton(
                title: "Начать игру",
                fontSize: 20,
                width: UIScreen.main.bounds.width * 0.85,
                height: 60
            ) {
                showInstructions = false
                onReturnToGame()
            }
            .padding(.top, 20)
        }
        .padding()
    }
}
