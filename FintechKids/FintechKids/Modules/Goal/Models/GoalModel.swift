//
//  File.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import Foundation

struct GoalModel: Hashable {
    var name: String
    var goalSum: Int
    var level: AimImportantLevels
    var current: Int
    var image: String
    var date: Date
    
    var progress: Int {
        get {
            return Int(Double(current) / Double(goalSum) * 100)
        }
    }
}

enum AimImportantLevels {
    case high
    case mid
    case low
}
