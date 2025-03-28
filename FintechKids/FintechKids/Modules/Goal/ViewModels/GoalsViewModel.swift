//
//  GoalsViewModel.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import Foundation

final class GoalsViewModel: ObservableObject {
    @Published var goals: [GoalModel] = [
        GoalModel(name: "Bike", goalSum: 50000, level: .high, current: 25000, image: "templateGoal", date: Date()),
        GoalModel(name: "PSP", goalSum: 50000, level: .high, current: 15000, image: "templateGoal", date: Date()),
        GoalModel(name: "Bike 2", goalSum: 50000, level: .high, current: 35000, image: "templateGoal", date: Date()),
        GoalModel(name: "PSP 2", goalSum: 50000, level: .high, current: 45000, image: "templateGoal", date: Date()),
        GoalModel(name: "Bike 3", goalSum: 50000, level: .high, current: 20000, image: "templateGoal", date: Date()),
        GoalModel(name: "PSP 3", goalSum: 50000, level: .high, current: 30000, image: "templateGoal", date: Date()),
        GoalModel(name: "Bike 4", goalSum: 50000, level: .high, current: 40000, image: "templateGoal", date: Date()),
        GoalModel(name: "PSP 4", goalSum: 50000, level: .high, current: 50000, image: "templateGoal", date: Date())
    ]
    
    // TODO: Тута добавить логику изменения цели
    func updateGoal(at index: Int) {    }
    
    func deleteGoal(at index: Int) {
        goals.remove(at: index)
    }
}
