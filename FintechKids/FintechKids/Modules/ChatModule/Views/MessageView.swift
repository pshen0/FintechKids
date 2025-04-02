//
//  MessageView.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

#Preview {
    MessageView(message: Message(title: "Lol", isYours: false))
}

struct MessageView: View {
    let message: Message
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                if message.isYours { Spacer() }
                else {
                    FinikAvatar()
                }
                
                VStack(alignment: MessageModel.getMessageStackAlignment(isYour: message.isYours)) {
                    Text(message.title)
                        .font(Font.custom(Fonts.deledda, size: FontSizes.default))
                        .padding(Padding.default)
                        .foregroundStyle(MessageModel.getTextColor(isYour: message.isYours))
                        .background {
                            MessageCorner(
                                radius: FontSizes.default,
                                corners: MessageModel.getMessageViewEdges(isYour: message.isYours)
                            )
                            .fill(MessageModel.getMessageColor(isYour: message.isYours))
                            .shadow(radius: 2)
                        }
                    
                    Text(Formatter.formatTime(date: message.date))
                        .font(Font.custom(Fonts.deledda, size: FontSizes.time))
                        .foregroundStyle(.secondary)
                }
                if !message.isYours { Spacer() }
            }
            .background(.clear)
        }
    }
}
