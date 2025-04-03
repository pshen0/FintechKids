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
            Image(systemName: "play.fill")
                .imageScale(.large)
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            Text("Приступип")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.blue)
            
            Text("Нажми на кнопку чтобы продолжить игру!")
                .font(.system(size: 18))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
                .lineSpacing(4)
            
            Button(action: onReturnToGame) {
                Text("Вернуться к игре")
                
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.highlightedBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal)
            .padding(.top, 20)
        }
        .padding()
    }
}

