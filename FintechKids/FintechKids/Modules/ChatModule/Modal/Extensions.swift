//
//  Extensions.swift
//  FintechKids
//
//  Created by Данил Забинский on 29.03.2025.
//

import SwiftUI

extension MessageListView {
    
    func scrollToLastMessage(proxy: ScrollViewProxy, animation: Bool = true) {
        if let message = viewModel.getCarefulLast() {
            if animation {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    proxy.scrollTo(message, anchor: .bottom)
                }
            } else {
                proxy.scrollTo(message, anchor: .bottom)
            }
        }
    }
}

extension View {
    func setupKeyboardObservers(keyboardHeight:       Binding<CGFloat>,
                                shouldScrollToBottom: Binding<Bool>) -> some View {
        onAppear {
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillShowNotification,
                object: nil,
                queue: .main) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        withAnimation(.spring) {
                            keyboardHeight.wrappedValue = keyboardFrame.height - ChatScreen.bottomInset
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                shouldScrollToBottom.wrappedValue = true
                            }
                        }
                    }
                }
            
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil,
                queue: .main) { _ in
                    withAnimation(.snappy) {
                        keyboardHeight.wrappedValue = 0
                        shouldScrollToBottom.wrappedValue = false
                    }
                }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self)
        }
    }
}

private extension ChatScreen {

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


