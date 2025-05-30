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
    let fontSize: CGFloat
    let width: CGFloat?
    let height: CGFloat?
    
    init(title: String, fontSize: CGFloat = 16, width: CGFloat? = nil, height: CGFloat? = nil, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.fontSize = fontSize
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(Font.custom(Fonts.deledda, size: fontSize))
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding()
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

