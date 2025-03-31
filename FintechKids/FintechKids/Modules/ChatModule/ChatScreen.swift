//
//  ChatScreen.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

#Preview {
    ChatScreen(viewModel: ChatViewModel(chatService: ChatService()))
}

struct ChatScreen: View {
    
    @State private var text: String = ""
    @State private var keyboardHeight: CGFloat = 0
    @State private var shouldScrollToBottom: Bool = false
    @State private var lastMessageCount: Int = 0
    @ObservedObject var viewModel: ChatViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient (
                    gradient: Gradient(stops: [
                        .init(color: .highlightedBackground, location: 0.2),
                        .init(color: .white, location: 0.6),
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()
                
                
                VStack {
                    ForEach(0...10, id: \.self) { number in
                        HStack {
                            if number % 2 == 0 { Spacer() }
                            Cloud()
                            if number % 2 != 0 { Spacer() }
                        }
                    }
                }
                
                VStack {
                    ScrollViewReader { proxy in
                        MessageList(
                            viewModel: viewModel,
                            shouldScrollToBottom: $shouldScrollToBottom,
                            proxy: proxy,
                            dismiss: { dismiss() })
                        
                        CreateMessageTextField(
                            viewModel: viewModel,
                            text: $text,
                            proxy: proxy)
                        .offset(y: -keyboardHeight / 100)
                    }
                    .background(.clear)
                }
                .setupKeyboardObservers(keyboardHeight:       $keyboardHeight,
                                        shouldScrollToBottom: $shouldScrollToBottom)
            }
        }
    }
}
