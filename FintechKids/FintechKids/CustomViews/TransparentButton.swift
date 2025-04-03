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
                .foregroundStyle(.primary)
                .frame(width: width, height: height)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.ultraThinMaterial)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                )
        }
    }
}
