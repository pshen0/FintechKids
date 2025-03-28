//
//  Formatter.swift
//  FintechKids
//
//  Created by Данил Забинский on 28.03.2025.
//

import Foundation

final class Formatter {
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
