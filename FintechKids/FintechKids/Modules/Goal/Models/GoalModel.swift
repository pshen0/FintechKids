//
//  File.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import Foundation

class GoalModel: ObservableObject {
    @Published var id: Int
    @Published var name: String = ""
    @Published var goalSum: Int = 0
    @Published var level: AimImportantLevels = .high
    @Published var current: Int = 0
    @Published var image: String = ""
    @Published var date: Date = Date.now
    
    var progress: Int {
        get {
            return Int(Double(current) / Double(goalSum) * 100)
        }
    }
    
    init(id: Int, name: String = "", goalSum: Int = 0, current: Int = 0, level: AimImportantLevels = .high, image: String = "", date: Date = Date.now) {
        self.id = id
        self.name = name
        self.goalSum = goalSum
        self.current = current
        self.level = level
        self.image = image
        self.date = date
    }
}

enum AimImportantLevels {
    case high
    case mid
    case low
}
