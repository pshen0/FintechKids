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
        Message(
            id: UUID(),
            title: """
            Привет! Я котенок Финик - твой друг. 
            
            Я очень хочу помочь тебе научиться разумно тратить карманные деньги и накопить на игрушки твоей мечты! 
            Задай мне любой вопрос, я постараюсь на него  ответить 🐱
            """,
                
            isYours: false),
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
