//
//  GoalsViewModel.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import Foundation

final class GoalsViewModel: ObservableObject {
    @Published var goals: [GoalModel] = [
        GoalModel(name: "PSP", goalSum: 50000, level: .high, current: 25000, image: "templateGoal", date: Date())
    ]
    
    @Published var selectedIndex: Int = 0
    
    // TODO: Тута добавить логику изменения цели
    func updateGoal(at index: Int) {    }
}
