//
//  CodableModels.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 03.04.2025.
//

import Foundation
import SwiftUI

struct GoalModelCodable: Codable {
    var name: String
    var goalSum: Int
    var level: Bool
    var current: Int
    var image: String
    var date: Date
    
    var progress: Int {
        return Int(Double(current) / Double(goalSum) * 100)
    }
    
    init(from goal: GoalModel) {
        self.name = goal.name
        self.goalSum = goal.goalSum
        self.current = goal.current
        self.level = goal.level
        self.image = goal.image
        self.date = goal.date
    }
    
    func toGoalModel() -> GoalModel {
        return GoalModel(name: name, goalSum: goalSum, current: current, level: level, image: image, date: date)
    }
}

struct GoalViewModelCodable: Codable {
    var id: Int
    var name: String
    var current: String
    var goalSum: String
    var isEdit: Bool
    var isFlipped: Bool
    var goal: GoalModelCodable
    
    init(from viewModel: GoalViewModel) {
        self.id = viewModel.id
        self.name = viewModel.name
        self.current = viewModel.current
        self.goalSum = viewModel.goalSum
        self.isEdit = viewModel.isEdit
        self.isFlipped = viewModel.isFlipped
        self.goal = GoalModelCodable(from: viewModel.goal)
    }
    
    func toGoalViewModel() -> GoalViewModel {
        let goalModel = goal.toGoalModel()
        return GoalViewModel(id: id, goal: goalModel, isEdit: isEdit, isFlipped: isFlipped)
    }
}
