//
//  TransparentButton.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 03.04.2025.
//

import SwiftUI

struct TransparentButton: View {
    let title: String
    let action: () -> Void
    let fontSize: CGFloat
    
    init(title: String, fontSize: CGFloat = 16, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.fontSize = fontSize
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(Font.custom(Fonts.deledda, size: fontSize))
                .fontWeight(.medium)
                .foregroundStyle(.primary)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.ultraThinMaterial)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                )
        }
    }
}

