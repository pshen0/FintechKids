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
    
    private var name: String {
        UserDefaults.standard.string(forKey: "userName") ?? "браток"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gamecontroller.fill")
                .imageScale(.large)
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            Text("Добро пожаловать!")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.blue)
            
            Text("Привет \(name)! Прокрути вправо, чтобы узнать больше о правилах и управлении")
                .font(.system(size: 18))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
                .lineSpacing(4)
        }
        .padding()
    }
}
