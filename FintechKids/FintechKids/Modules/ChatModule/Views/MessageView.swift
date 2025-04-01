//
//  MessageView.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                if message.isYours { Spacer() }
                else {
                    Circle()
                        .fill(.background.opacity(0.8).gradient)
                        .frame(height: ChatConstants.finikAvatar.height)
                        .overlay {
                            Image(.cat)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(Padding.small)
                        }
                }
                
                VStack(alignment: MessageModel.getMessageStackAlignment(isYour: message.isYours)) {
                    Text(message.title)
                        .modifier(CustomFont(size: FontSizes.default))
                        .padding(Padding.default)
                        .foregroundStyle(.white)
                        .background {
                            MessageCorner(
                                radius: FontSizes.default,
                                corners: MessageModel.getMessageViewEdges(isYour: message.isYours)
                            )
                            .fill(MessageModel.getMessageColor(isYour: message.isYours))
                            .shadow(radius: 2)
                        }
                    
                    Text(Formatter.formatTime(date: message.date))
                        .modifier(CustomFont(size: FontSizes.time))
                        .foregroundStyle(.secondary)
                } 
                if !message.isYours { Spacer() }
            }
            .background(.clear)
        }
    }
}
