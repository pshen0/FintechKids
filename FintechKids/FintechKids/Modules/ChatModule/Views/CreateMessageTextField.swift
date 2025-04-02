//
//  CreateMessageTextField.swift
//  FintechKids
//
//  Created by Данил Забинский on 29.03.2025.
//

import SwiftUI

struct CreateMessageTextField: View {
    @ObservedObject var viewModel: ChatViewModel
    @Binding var text: String
    let proxy: ScrollViewProxy
    
    var body: some View {
        HStack {
            TextField("Спроси у Финика", text: $text)
                .modifier(CreateMessageTextFieldModifier())
            SendButton
        }
        .padding(.horizontal, Padding.medium)
        .padding(.vertical, Padding.default)
        .background(.clear)
    }
    
    private var SendButton: some View {
        Button(action: sendMessage) {
            Image(systemName: SystemImage.sendMessage.getSystemName)
                .font(.system(size: FontSizes.big, weight: .medium))
                .foregroundColor(viewModel.isSendingMessagesEnable(text: text) ? .highlightedBackground : .text)
        }
        .disabled(viewModel.isSendingMessagesEnable(text: text))
    }
    
    private func sendMessage() {
        let messageText = text
        text = ""
        
        Task { await viewModel.createMessage(messageText: messageText) }
    }
}
