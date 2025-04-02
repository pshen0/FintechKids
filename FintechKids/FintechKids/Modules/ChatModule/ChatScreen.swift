//
//  ChatScreen.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI
import SwiftData

struct ChatScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @ObservedObject var viewModel: ChatViewModel
    
    @State private var text = ""
    @State private var keyboardHeight: CGFloat = 0
    @State private var shouldScrollToBottom = false
    
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
                            messages: viewModel.messages,
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
                .toolbarBackground(.highlightedBackground.opacity(0.8), for: .navigationBar)
                .setupKeyboardObservers(
                    keyboardHeight: $keyboardHeight,
                    shouldScrollToBottom: $shouldScrollToBottom
                )
            }
        }
    }
}
