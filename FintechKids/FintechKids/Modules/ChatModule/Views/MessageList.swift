//
//  MessageList.swift
//  FintechKids
//
//  Created by Данил Забинский on 29.03.2025.
//

import SwiftUI
import SwiftData

struct MessageList: View {
    @ObservedObject var viewModel: ChatViewModel
    @Binding var shouldScrollToBottom: Bool
    
    let messages: [Message]
    var proxy: ScrollViewProxy
    var dismiss: (() -> Void)
    
    
    private var grouppedMessages: [(Date, [Message])] {
        let grouped = Dictionary(grouping: messages) { message in
            Calendar.current.startOfDay(for: message.date)
        }
        return grouped.sorted { $0.key < $1.key }
    }
    
    var body: some View {
        List {
            ForEach(grouppedMessages, id: \.0) { (date, messages) in
                Section {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Text(Formatter.formatDay(date: date))
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(Padding.default)
                            .background(
                                Capsule()
                                    .fill(Color(.text.opacity(0.25)))
                            )
                            .shadow(radius: Padding.small)
                        
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                
                ForEach(messages) { message in
                    MessageView(message: message)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                
                if viewModel.isManagerProcessing {
                    HStack {
                        Spacer()
                        
                        TypingIndicator()
                            .padding(.top, Padding.default)
                        
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
            }
        }
        .background(.clear)
        .onAppear {
            scrollToLastMessage(proxy: proxy)
        }
        .onChange(of: shouldScrollToBottom) { _, newValue in
            if newValue {
                scrollToLastMessage(proxy: proxy)
            }
        }
        .onChange(of: messages) { _, _ in
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
        }, viewModel: viewModel))
    }
}
