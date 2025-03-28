//
//  File.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import Foundation

struct GoalModel {
    var name: String
    var goalSum: Int
    var level: AimImportantLevels
    var current: Int
    var image: String
    var date: Date
}

enum AimImportantLevels {
    case high
    case mid
    case low
}
