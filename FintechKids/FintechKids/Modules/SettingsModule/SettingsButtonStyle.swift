//
//  SettingsButtonStyle.swift
//  FintechKids
//
//  Created by George Petryaev on 03.04.2025.
//

import SwiftUI

struct SettingsButtonStyle: ButtonStyle {
    var backgroundColor: Color = .highlightedBackground
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom(Fonts.deledda, size: 18))
            .fontWeight(.bold)
            .foregroundColor(.text)
            .padding()
            .background(backgroundColor)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(color: .highlightedBackground, radius: 6)
    }
} 
