//
//  ChatScreen.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI
import UIKit

struct ChatScreen: View {
    
    @State private var text: String = ""
    @State private var keyboardHeight: CGFloat = 0
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    Group {
                        
                        List {
                            ForEach(viewModel.data) { message in
                                MessageView(message: message)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .listStyle(.plain)
                        .scrollIndicators(.hidden)
                        .navigationTitle("Чат с Фиником")
                        .navigationBarTitleDisplayMode(.inline)
                        .onAppear {
                            if let lastMessage = viewModel.data.last {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                        .onChange(of: viewModel.data, { oldValue, newValue in
                            proxy.scrollTo(newValue.last!.id, anchor: .bottom)
                        })
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                            to: nil,
                                                            from: nil,
                                                            for: nil)
                        }
                        
                        textField(proxy: proxy, viewModel: viewModel, text: $text)
                            .offset(y: -keyboardHeight / 100)
                    }
                }
            }
            .onAppear {
                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillShowNotification,
                    object: nil,
                    queue: .main) { notification in
                        
                        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                            withAnimation(.spring) {
                                keyboardHeight = keyboardFrame.height - ChatScreen.bottomInset
                            }
                        }
                    }
                
                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillHideNotification,
                    object: nil,
                    queue: .main) { _ in
                        withAnimation(.snappy) {
                            self.keyboardHeight = 0
                        }
                    }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self)
            }
        }
    }
    
    struct textField: View {
        var proxy: SwiftUI.ScrollViewProxy
        var viewModel: ChatViewModel
        @Binding var text: String
        
        var body: some View {
            HStack {
                TextField("Спроси у Финика", text: $text)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color(UIColor.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: .black.opacity(0.1), radius: 5)
                
                Button(action: {
                    if !text.isEmpty {
                        let createdMessageId = viewModel.createMessage(text: &text)
                        proxy.scrollTo(createdMessageId, anchor: .bottom)
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(text.isEmpty ? Color.gray : Color.blue)
                }
                .disabled(text.isEmpty)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(Color.white)
        }
    }
}

extension ChatScreen {
    static var bottomInset: CGFloat {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .first(where: { $0.isKeyWindow }) else {
            return 0
        }
        return window.safeAreaInsets.bottom
    }
}
