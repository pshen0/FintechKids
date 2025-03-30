//
//  ChatViewModel.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

struct Message: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let date = Date()
    let isYour: Bool
}

class Formatter {
    static func formatDate(date: Date) -> String {
        timeFormatter.string(from: date)
    }
    
    static var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = .current
        return formatter
    }()
}

class ChatViewModel: ObservableObject {
    
    @Published var data: [Message] = [
        Message(title: "HI", isYour: true),
        Message(title: "How are you", isYour: false),
        Message(title: "Im fine and you", isYour: true),
        Message(title: "OOOh i feel my self bla bla fladjf dklsajfklasdjfklasdjf klasjfd kladjf lkasdjf klajdf kladsjf lkasjdf klasjdflk asjdfl kjasdlk fjsdakl fjaslkd fjalksd jflaksd jfaklsdj faskld jfaskldfj alskd j", isYour: false),
        Message(title: "Wow", isYour: false),
        Message(title: "Yep", isYour: true),
        Message(title: "HI", isYour: true),
        Message(title: "How are you", isYour: false),
        Message(title: "Im fine and you", isYour: true),
        Message(title: "OOOh i feel my self bla bla fladjf dklsajfklasdjfklasdjf klasjfd kladjf lkasdjf klajdf kladsjf lkasjdf klasjdflk asjdfl kjasdlk fjsdakl fjaslkd fjalksd jflaksd jfaklsdj faskld jfaskldfj alskd j", isYour: false),
        Message(title: "Wow", isYour: false),
        Message(title: "Yep", isYour: true),
    ]
    
    func createMessage(text: inout String) -> UUID {
        let message = Message(title: text, isYour: true)
        data.append(message)
        text = ""
        return message.id
    }
    
    func a() {
        data.append(Message(title: "", isYour: true))
    }
}
