//
//  Item.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 25.03.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
