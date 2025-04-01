//
//  File.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import Foundation

class GoalModel: ObservableObject {
    @Published var name: String = "Goal"
    @Published var goalSum: Int = 1
    @Published var level: AimImportantLevels = .high
    @Published var current: Int = 0
    @Published var image: String = "templateGoal"
    @Published var date: Date = Date.now
    
    var progress: Int {
        get {
            return Int(Double(current) / Double(goalSum) * 100)
        }
    }
    
    init(name: String = "", goalSum: Int = 0, current: Int = 0, level: AimImportantLevels = .high, image: String = "", date: Date = Date.now) {
        self.name = name
        self.goalSum = goalSum
        self.current = current
        self.level = level
        self.image = image
        self.date = date
    }
    
    init() { }
}

enum AimImportantLevels {
    case high
    case mid
    case low
}
