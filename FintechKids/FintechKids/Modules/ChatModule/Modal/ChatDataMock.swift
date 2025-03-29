//
//  ChatDataMock.swift
//  FintechKids
//
//  Created by Данил Забинский on 28.03.2025.
//

import Foundation

enum ChatDataMock {
    static var calendar = Calendar.current
    
    static let `default`: [Message] = [
        Message(title: "1 HI", isYour: true),
        Message(title: "2 How are you", isYour: false),
        Message(title: "3 Im fine and you", isYour: true),
        Message(title: "4 O", isYour: false),
        Message(title: "5 Wow", isYour: false),
        Message(title: "6 Yep", isYour: true),
        Message(title: "7 HI", isYour: true),
        Message(title: "8 How are you", isYour: false),
        Message(title: "9 Im fine and you", isYour: true),
        Message(title: "10 OOOh i feel my self bla bla fladjf dklsajfklasdjfklasdjf klasjfd kladjf lkasdjf klajdf kladsjf lkasjdf klasjdflk asjdfl kjasdlk fjsdakl fjaslkd fjalksd jflaksd jfaklsdj faskld jfaskldfj alskd j", isYour: false),
        Message(title: "11 Wow", isYour: false),
        Message(title: "12 Yep", isYour: true),
    ]
    
    static func getMessagesByDay() -> [(Date, [Message])] {
        let calendar = Calendar.current
        
        let groupedDict = Dictionary(grouping: ChatDataMock.default) { message in
            calendar.startOfDay(for: message.date)
        }
        
        let sorted = groupedDict.sorted { $0.key < $1.key }
        
        return sorted
    }
}
