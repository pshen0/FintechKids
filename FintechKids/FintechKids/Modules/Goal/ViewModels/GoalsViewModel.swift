//
//  GoalsViewModel.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import Foundation
import SwiftUI

final class GoalsViewModel: ObservableObject {
    @Published var currentID: Int = 10
    
    @Published var goalViewModels: [GoalViewModel] = [] {
        didSet {
            saveGoals()
        }
    }
    
    init() {
        loadGoals()
    }
    
    func saveGoals() {
        var goals: [GoalViewModelCodable] = []
        
        for i in goalViewModels {
            goals.append(GoalViewModelCodable(from: i))
        }
        
        if let encoded = try? JSONEncoder().encode(goals) {
                UserDefaults.standard.set(encoded, forKey: "goals")
            }
        }

    func loadGoals() {
        currentID = UserDefaults.standard.integer(forKey: "id")
        if let data = UserDefaults.standard.data(forKey: "goals"),
           let decodedGoals = try? JSONDecoder().decode([GoalViewModelCodable].self, from: data) {
            goalViewModels = decodedGoals.map({$0.toGoalViewModel()})
        }
    }
    
    func deleteGoal(at id: Int) {
        goalViewModels.remove(at: getIndexById(with: id))
        saveGoals()
    }
    
    func getIndexById(with id: Int) -> Array<GoalModel>.Index {
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
        UserDefaults.standard.set(currentID, forKey: "id")
        goal.id = currentID
        
        goalViewModels.insert(goal, at: 0)
        saveGoals()
    }
    
    func updateGoal(with id: Int, with newGoal: GoalViewModel) {
        if let index = goalViewModels.firstIndex(where: { $0.id == id }) {
            goalViewModels[index] = newGoal
        }
    }
}
