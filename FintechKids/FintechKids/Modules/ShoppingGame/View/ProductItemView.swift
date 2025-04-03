//
//  ProductItemView.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 01.04.2025.
//

import SwiftUI

struct ProductItemView: View {
    let product: CardGameRound
    let isSelected: Bool
    let isTimeUp: Bool
    let onTap: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            backgroundRectangle
            selectionOverlay
        }
        .onTapGesture {
            if !isTimeUp {
                withAnimation(Animation.spring(response: 0.3, dampingFraction: 0.6)) {
                    onTap()
                }
            }
        }
    }
    
    private var selectionBorder: some View {
        RoundedRectangle(cornerRadius: 14)
            .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
    }
    
    private var backgroundRectangle: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(.highlightedBackground.gradient)
            .frame(height: 90)
            .overlay(selectionBorder)
            .opacity(isTimeUp ? 0.5 : 1.0)
            .scaleEffect(isSelected ? 1.02 : 1.0)
            .animation(
                Animation.spring(response: 0.3, dampingFraction: 0.6),
                value: isSelected)
            .overlay(
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                    .padding(.horizontal, 10)
            )
    }

    private var selectedBorder: some View {
        RoundedRectangle(cornerRadius: 14)
            .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
    }
    
    private var checkmarkIcon: some View {
        Image(systemName: "checkmark.circle.fill")
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(Circle())
            .padding(8)
            .transition(AnyTransition.scale.combined(with: .opacity))
    }
    
    private var selectionOverlay: some View {
        Group {
            if isSelected {
                checkmarkIcon
            }
        }
    }
}
