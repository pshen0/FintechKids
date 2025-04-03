//
//  GradientButton.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 02.04.2025.
//

import SwiftUI

struct GradientButton: View {
    let title: String
    let action: () -> Void
    let width: CGFloat
    let height: CGFloat
    
    init(title: String, width: CGFloat = 50, height: CGFloat = 50, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(Font.custom(Fonts.deledda, size: 16))
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .frame(width: width, height: height)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.highlightedBackground, Color.highlightedBackground.opacity(0.8)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: Color.highlightedBackground.opacity(0.5), radius: 5, x: 0, y: 2)
                )
        }
    }
}

