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
            HStack(alignment: .top) {
                if message.isYour { Spacer() }
                else {
                    Image(systemName: "swift")
                        .padding(5)
                        .foregroundStyle(.white)
                        .background {
                            Circle()
                                .fill(.orange)
                        }
                }
                
                VStack(alignment: message.isYour ? .trailing : .leading, spacing: 5) {
                    Text(message.title)
                        .padding(8)
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(message.isYour ? .gray : .blue)
                        }
                    
                    Text(Formatter.formatTimeDate(date: message.date))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                if !message.isYour { Spacer() }
            }
        }
    }
}

#Preview {
    Group {
        MessageView(message: Message(title: "1", isYour: true))
        MessageView(message: Message(title: "123456789", isYour: false))
    }
}
