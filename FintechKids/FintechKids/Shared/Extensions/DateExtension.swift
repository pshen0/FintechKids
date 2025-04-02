//
//  DateExtension.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.timeStyle = .none
        formatter.dateStyle = .short 
        return formatter.string(from: self)
    }
}
