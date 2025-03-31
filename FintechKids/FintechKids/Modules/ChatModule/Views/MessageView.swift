//
//  MessageView.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

struct MessageView: View {
    
    var message: Message
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                if message.isYour { Spacer() }
                else {
                    Image(.cat)
                        .resizable()
                        .frame(width: ChatConstants.finikAvatar.width, height: ChatConstants.finikAvatar.height)
                        .aspectRatio(contentMode: .fill)
                        .padding(Padding.small)
                        .background {
                            Circle()
                                .fill(.background.opacity(0.8).gradient)
                        }
                }
                
                VStack(alignment: message.isYour ? .trailing : .leading) {
                    Text(message.title)
                        .modifier(CustomFont(size: Font.default))
                        .padding(Padding.default)
                        .foregroundStyle(.white)
                        .background {
                            MessageCorner(
                                radius: Font.default,
                                corners: message.isYour ? [.topLeft, .topRight, .bottomLeft] :                              [.topRight, .topLeft, .bottomRight]
                            )
                            .fill(message.isYour ? .text : .highlightedBackground)
                        }
                    
                    Text(Formatter.formatTimeDate(date: message.date))
                        .modifier(CustomFont(size: Font.time))
                        .foregroundStyle(.secondary)
                }
                
                if !message.isYour { Spacer() }
            }
            .background(.clear)
        }
    }
}

#Preview {
    Group {
        MessageView(message: Message(title: "1", isYour: true))
        MessageView(message: Message(title: "123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789", isYour: false))
    }
}
