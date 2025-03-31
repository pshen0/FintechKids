//
//  Message.swift
//  FintechKids
//
//  Created by Данил Забинский on 28.03.2025.
//

import Foundation

struct Message: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let date = Date()
    let isYour: Bool
}
