//
//  Message.swift
//  FintechKids
//
//  Created by Данил Забинский on 28.03.2025.
//

import Foundation
import SwiftData

@Model
final class Message: Hashable, Identifiable {
    var id: UUID
    var title: String
    var date: Date
    var isYours: Bool
    
    init(id: UUID = UUID(), title: String, date: Date = Date(), isYours: Bool) {
        self.id = id
        self.title = title
        self.date = date
        self.isYours = isYours
    }
}
