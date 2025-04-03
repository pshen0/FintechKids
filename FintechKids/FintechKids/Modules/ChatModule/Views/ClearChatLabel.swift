//
//  ClearChatLabel.swift
//  FintechKids
//
//  Created by Данил Забинский on 02.04.2025.
//

import SwiftUI

struct ClearChatLabel: View {
    var viewModel: ChatViewModel
    
    var body: some View {
        HStack(spacing: Padding.small) {
            Image(systemName: "trash")
        }
        .foregroundStyle(.red)
        .padding(Padding.default)
        .font(Font.custom(Fonts.deledda, size: FontSizes.default))
        .opacity(viewModel.messages.isEmpty ? 0.5 : 1)
    }
}

