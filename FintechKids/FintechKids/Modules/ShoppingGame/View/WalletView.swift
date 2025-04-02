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
            .fill(Color.blue.opacity(0.1))
            .frame(height: 80)
    }
    
    private var walletIcon: some View {
        Image(systemName: "wallet.pass.fill")
            .font(.title2)
            .foregroundStyle(.blue)
            .bold()
    }
    
    private var walletInfo: some View {
        VStack(alignment: .leading, spacing: 0.4) {
            Text("Кошелек")
                .font(.subheadline)
                .foregroundStyle(.gray)
            Text("\(pocket)р")
                .font(.title2)
                .bold()
                .foregroundStyle(.blue)
        }
    }
    
    private var infoButton: some View {
        Button(action: onInfoTapped) {
            Image(systemName: "info.circle.fill")
                .font(.title2)
                .foregroundStyle(.blue)
        }
    }
}
