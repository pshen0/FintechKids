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
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
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
    }
}

struct ListWithMessagesModifier: ViewModifier {
    let dismiss: (() -> Void)
    
    func body(content: Content) -> some View {
        content
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .navigationTitle("Чат с Фиником")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        ButtonLabel()
                    }
                }
            }
    }
}
