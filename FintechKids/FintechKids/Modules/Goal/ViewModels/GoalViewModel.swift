//
//  GoalViewModel.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 28.03.2025.
//

import Foundation
import SwiftUI

final class GoalViewModel: ObservableObject /*Equatable*/ {
//    static func == (lhs: GoalViewModel, rhs: GoalViewModel) -> Bool {
//        return lhs.isEdit == rhs.isEdit
//    }
    
    @Published var id: Int
    @Published var name: String = ""
    @Published var current: String = ""
    @Published var goalSum: String = ""
    @Published var isEdit: Bool = false
    @Published var isFlipped: Bool = false
    var goal: GoalModel
    
    init(id: Int, goal: GoalModel, isEdit: Bool = false, isFlipped: Bool = false) {
        self.id = id
        self.goal = goal
        self.goal.image = goal.image.appending(String(id))
        self.name = self.goal.name
        self.current = "\(self.goal.current)"
        self.goalSum = "\(self.goal.goalSum)"
        self.isEdit = isEdit
        self.isFlipped = isFlipped
    }
    
    func updateGoal() {
        if let newCurrent = Int(current), let newGoalSum = Int(goalSum) {
            if newCurrent < newGoalSum && newGoalSum != 0 {
                goal.current = newCurrent
                goal.goalSum = newGoalSum
            }
        }
        goal.name = name
    }
}
