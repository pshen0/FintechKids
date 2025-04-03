//
//  ProgressBar.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 28.03.2025.
//

import SwiftUI

struct CustomProgressView: View {
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: geometry.size.width / 2)
                    .fill(Color.cardBackSide)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.text, lineWidth: 2)
                    )
                
                RoundedRectangle(cornerRadius: geometry.size.width / 2)
                    .frame(width: geometry.size.width, height: progress < 0.05 ? 0: max(progress * geometry.size.height, 15))
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .animation(.easeInOut, value: progress)
                    .foregroundStyle(Color.text)
                    .clipped()
            }
        }
    }
}
