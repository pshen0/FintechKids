//
//  Formatter.swift
//  FintechKids
//
//  Created by Данил Забинский on 28.03.2025.
//

import Foundation

enum Formatter {
    static func formatTime(date: Date) -> String {
        timeFormatter.string(from: date)
    }
    
    static func formatDay(date: Date) -> String {
        dayFormatter.string(from: date)
    }
    
    private static var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = .current
        return formatter
    }()
    
    private static var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM"
        formatter.dateStyle = .medium
        formatter.locale = .current
        return formatter
    }()
}
