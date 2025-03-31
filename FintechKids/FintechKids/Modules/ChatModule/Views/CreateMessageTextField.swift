//
//  CreateMessageTextField.swift
//  FintechKids
//
//  Created by Данил Забинский on 29.03.2025.
//

import SwiftUI

struct CreateMessageTextField: View {
    
    @Binding var text: String
    let proxy: ScrollViewProxy
    let viewModel: ChatViewModel
    
    var body: some View {
        HStack {
            TextField("Спроси у Финика", text: $text)
                .modifier(CreateMessageTextFieldModifier())
            
            SendButton
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(.clear)
    }
    
    private var SendButton: some View {
        Button(action: sendMessage) {
            Image(systemName: SystemImage.sendMessage.getSystemName)
                .font(.system(size: Font.big, weight: .medium))
                .foregroundColor(text.isEmpty ? .highlightedBackground : .text)
        }
        .disabled(text.isEmpty)
    }
    
    private func sendMessage() {
        if !text.isEmpty {
            viewModel.createMessage(text: &text)
            lastMessageCount += 1
        }
    }
}
