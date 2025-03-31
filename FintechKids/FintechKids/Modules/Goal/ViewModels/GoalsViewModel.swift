//
//  GoalsViewModel.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import Foundation
import SwiftUI

final class GoalsViewModel: ObservableObject {
    var currentID: Int = 8
    
    @Published var goalViewModels: [GoalViewModel] = [
        GoalViewModel(id: 0, goal: GoalModel(name: "Bike", goalSum: 50000, current: 25000, level: .high, image: "templateGoal0.jpg", date: Date()))
//        GoalViewModel(id: 1, goal: GoalModel(name: "PSP", goalSum: 50000, current: 15000, level: .high, image: "templateGoal1.jpg", date: Date())),
//        GoalViewModel(id: 2, goal: GoalModel(name: "Bike 2", goalSum: 50000, current: 35000, level: .high, image: "templateGoal2.jpg", date: Date())),
//        GoalViewModel(id: 3, goal: GoalModel(name: "PSP 2", goalSum: 50000, current: 45000, level: .high, image: "templateGoal3.jpg", date: Date())),
//        GoalViewModel(id: 4, goal: GoalModel(name: "Bike 3", goalSum: 50000, current: 20000, level: .high, image: "templateGoal4.jpg", date: Date())),
//        GoalViewModel(id: 5, goal: GoalModel(name: "PSP 3", goalSum: 50000, current: 30000, level: .high, image: "templateGoal5.jpg", date: Date())),
//        GoalViewModel(id: 6, goal: GoalModel(name: "Bike 4", goalSum: 50000, current: 40000, level: .high, image: "templateGoal6.jpg", date: Date())),
//        GoalViewModel(id: 7, goal: GoalModel(name: "PSP 4", goalSum: 50000, current: 50000, level: .high, image: "templateGoal7.jpg", date: Date()))
    ]
    
    func deleteGoal(at id: Int) {
        goalViewModels.remove(at: getIndexById(at: id))
    }
    
    func getIndexById(at id: Int) -> Array<GoalModel>.Index {
        guard let index = goalViewModels.firstIndex(where: { $0.id == id }) else {
            fatalError("Goal with id \(id) not found")
        }
        return index
    }
    
    func count() -> Int {
        return goalViewModels.count
    }
    
    func addNew(goal: GoalViewModel) {
        currentID += 1
        
        goalViewModels.insert(goal, at: 0)
    }
}
