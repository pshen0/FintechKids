//
//  ChatScreen.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

struct ChatScreen: View {
    
    @State private var text: String = ""
    @State private var keyboardHeight: CGFloat = 0
    @State private var shouldScrollToBottom: Bool = false
    @State private var lastMessageCount: Int = 0
    @ObservedObject var viewModel: ChatViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    MessageListView(
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
            }
            .setupKeyboardObservers(keyboardHeight:       $keyboardHeight,
                                    shouldScrollToBottom: $shouldScrollToBottom)
        }
    }
}

struct MessageListView: View {
    
    @Binding var shouldScrollToBottom: Bool
    @Binding var lastMessageCount: Int
    var proxy: ScrollViewProxy
    var viewModel: ChatViewModel
    var dismiss: (() -> Void)
    
    var body: some View {
        List {
            ForEach(viewModel.data, id: \.0) { (date, messages) in
                
                Section {
                    ForEach(messages, id: \.self) { message in
                        MessageView(message: message)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    Text(Formatter.formatDayDate(date: date))
                        .modifier(MessagesDateModifier())
                }
            }
        }
        .onAppear {
            scrollToLastMessage(proxy: proxy, animation: false)
        }
        .onChange(of: shouldScrollToBottom) { _, newValue in
            if newValue {
                scrollToLastMessage(proxy: proxy)
            }
        }
        .onChange(of: lastMessageCount) { _, _ in
            scrollToLastMessage(proxy: proxy)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
        .modifier(ListWithMessagesModifier(dismiss: {
            dismiss()
        }))
    }
}

struct CreateMessageTextField: View {
    
    @Binding var text: String
    @Binding var lastMessageCount: Int
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
        .background(Color.white)
    }
    
    private var SendButton: some View {
        Button(action: sendMessage) {
            Image(systemName: "paperplane.fill")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(text.isEmpty ? Color.gray : Color.blue)
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

struct ButtonLabel: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "chevron.left")
                .fontWeight(.medium)
            Text("Назад")
        }
    }
}
