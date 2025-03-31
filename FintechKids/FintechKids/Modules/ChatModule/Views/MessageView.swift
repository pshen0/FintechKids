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
                if message.isYour { Spacer() }
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
                
                VStack(alignment: MessageModel.getMessageStackAlignment(isYour: message.isYour)) {
                    Text(message.title)
                        .modifier(CustomFont(size: FontValues.default))
                        .padding(Padding.default)
                        .foregroundStyle(.white)
                        .background {
                            MessageCorner(
                                radius: FontValues.default,
                                corners: MessageModel.getMessageViewEdges(isYour: message.isYour)
                            )
                            .fill(MessageModel.getMessageColor(isYour: message.isYour))
                            .shadow(radius: 2)
                        }
                    
                    Text(Formatter.formatTimeDate(date: message.date))
                        .modifier(CustomFont(size: FontValues.time))
                        .foregroundStyle(.secondary)
                } 
                if !message.isYour { Spacer() }
            }
            .background(.clear)
        }
    }
}
