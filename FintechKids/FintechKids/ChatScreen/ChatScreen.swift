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
    @State private var keyboardHeight = bottomInset
    

    var body: some View {
        VStack {
            Spacer()
            Group {
                Divider()
                
                TextField("Напиши Финику", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .offset(y: -keyboardHeight)
                    .padding(.horizontal, 10)
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillShowNotification,
                object: nil,
                queue: .main) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    keyboardHeight = keyboardFrame.height
                }
            }

            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil,
                queue: .main) { _ in
                self.keyboardHeight = 30
            }
        }
        .edgesIgnoringSafeArea(.bottom) // Игнорируем нижнюю безопасную зону для корректного отображения
    }
}

#Preview {
    ChatScreen()
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
