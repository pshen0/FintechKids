//
//  Modifiers.swift
//  FintechKids
//
//  Created by Данил Забинский on 29.03.2025.
//

import SwiftUI

struct MessagesDateModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color(UIColor.systemGray4))
                )
    }
}

struct CreateMessageTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(Color(UIColor.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .black.opacity(0.1), radius: 5)
            .font(Font.custom(Fonts.deledda, size: FontSizes.default))
    }
}

struct ListWithMessagesModifier: ViewModifier {

    let dismiss: (() -> Void)
    let viewModel: ChatViewModel
    
    @State private var confirmDeleting: Bool = false
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 2)
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .background(.clear)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        DismissButtonLabel()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        confirmDeleting = true
                    } label: {
                        ClearChatLabel(viewModel: viewModel)
                    }
                }
            }
            .alert(isPresented: $confirmDeleting) {
                Alert(title: Text("Ты уверен?"),
                      message: Text("Удаленную переписку нельзя восстановить"),
                      primaryButton: .destructive(Text("Очистить")) {
                    viewModel.clearStorage()
                }, secondaryButton: .cancel(Text("Отменить")))
            }
            .disabled(viewModel.messages.isEmpty)
    }
}
