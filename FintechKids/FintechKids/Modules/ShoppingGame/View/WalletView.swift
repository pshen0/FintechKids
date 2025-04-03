//
//  WalletView.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 01.04.2025.
//

import Foundation
import SwiftUI

struct WalletView: View {
    let pocket: Int
    let onInfoTapped: () -> Void
    
    var body: some View {
        HStack {
            ZStack {
                backgroundView
                contentStack
            }
        }
        .padding(.horizontal)
    }
    
    private var contentStack: some View {
        HStack(spacing: 15) {
            walletIcon
            walletInfo
            Spacer()
            infoButton
        }
        .padding(.horizontal, 20)
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.highlightedBackground.opacity(0.3))
            .frame(height: 80)
    }
    
    private var walletIcon: some View {
        Image(systemName: "wallet.pass.fill")
            .font(.title2)
            .foregroundStyle(.text.opacity(0.9))
            .bold()
    }
    
    private var walletInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Кошелек")
                .font(Font.custom(Fonts.deledda, size: 16))
                .foregroundStyle(.gray)
            Text("1000р")
                .font(Font.custom(Fonts.deledda, size: 26))
                .bold()
                .foregroundStyle(.text.opacity(0.9))
        }
    }
    
    private var infoButton: some View {
        Button(action: onInfoTapped) {
            Image(systemName: "info.circle.fill")
                .font(.title2)
                .foregroundStyle(.text.opacity(0.9))
        }
    }
}
