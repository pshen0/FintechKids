//
//  GoalsViewModel.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import Foundation
import SwiftUI

final class GoalsViewModel: ObservableObject {
    @Published var goals: [GoalModel] = [
        GoalModel(id: 0, name: "Bike", goalSum: 50000, current: 25000, level: .high, image: "templateGoal", date: Date()),
        GoalModel(id: 1, name: "PSP", goalSum: 50000, current: 15000, level: .high, image: "templateGoal", date: Date()),
        GoalModel(id: 2, name: "Bike 2", goalSum: 50000, current: 35000, level: .high, image: "templateGoal", date: Date()),
        GoalModel(id: 3, name: "PSP 2", goalSum: 50000, current: 45000, level: .high, image: "templateGoal", date: Date()),
        GoalModel(id: 4, name: "Bike 3", goalSum: 50000, current: 20000, level: .high, image: "templateGoal", date: Date()),
        GoalModel(id: 5, name: "PSP 3", goalSum: 50000, current: 30000, level: .high, image: "templateGoal", date: Date()),
        GoalModel(id: 6, name: "Bike 4", goalSum: 50000, current: 40000, level: .high, image: "templateGoal", date: Date()),
        GoalModel(id: 7, name: "PSP 4", goalSum: 50000, current: 50000, level: .high, image: "templateGoal", date: Date())
    ]
    
    func deleteGoal(at id: Int) {
        goals.remove(at: getIndexById(at: id))
    }
    
    func getIndexById(at id: Int) -> Array<GoalModel>.Index {
        guard let index = goals.firstIndex(where: { $0.id == id }) else {
            fatalError("Goal with id \(id) not found")
        }
        return index
    }
    
    func count() -> Int {
        return goals.count
    }
}
