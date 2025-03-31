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
            .modifier(CustomFont(size: 16))
    }
}

struct ListWithMessagesModifier: ViewModifier {
    let dismiss: (() -> Void)
    
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
            }
    }
}

struct CustomFont: ViewModifier {
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom("DeleddaOpen-Light", size: size))
    }
}
