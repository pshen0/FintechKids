//
//  TypingIndicator.swift
//  FintechKids
//
//  Created by Данил Забинский on 31.03.2025.
//

import SwiftUI

struct TypingIndicator: View {
    @State private var animationOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            Circle()
                .fill(.background.opacity(0.8).gradient)
                .frame(height: ChatConstants.finikAvatar.height)
                .overlay {
                    Image(.cat)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(Padding.small)
                }
            
            HStack(spacing: Padding.small) {
                ForEach(0 ..< 3) { index in
                    Circle()
                        .fill(Color(.white))
                        .frame(width: 8, height: 8)
                        .offset(y: animationOffset)
                        .animation(
                            Animation
                                .easeInOut(duration: 0.5)
                                .repeatForever()
                                .delay(0.2 * Double(index)),
                            value: animationOffset
                        )
                }
            }
            .padding(Padding.default)
            .background(
                Capsule()
                    .fill(Color(.highlightedBackground))
            )
            .onAppear {
                animationOffset = -5
            }
        }
        
        Spacer()
    }
}
