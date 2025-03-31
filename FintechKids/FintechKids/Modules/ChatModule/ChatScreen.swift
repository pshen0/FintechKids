//
//  ChatScreen.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

#Preview {
    ChatScreen(viewModel: ChatViewModel())
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
                            
                            Image(systemName: SystemImage.cloud.getSystemName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: Double.random(in: 40...120))
                                .foregroundStyle(.white.opacity(Double.random(in: 0.5...1)))
                                .padding(.horizontal, Double.random(in: 2...5) * 20.0)
                            
                            if number % 2 != 0 { Spacer() }
                        }
                    }
                }
                
                VStack {
                    ScrollViewReader { proxy in
                        MessageList(
                            shouldScrollToBottom: $shouldScrollToBottom,
                            lastMessageCount: $lastMessageCount,
                            proxy: proxy,
                            viewModel: viewModel,
                            dismiss: { dismiss() })
                        
                        CreateMessageTextField(
                            text: $text,
                            lastMessageCount: $lastMessageCount,
                            proxy: proxy,
                            viewModel: viewModel)
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
