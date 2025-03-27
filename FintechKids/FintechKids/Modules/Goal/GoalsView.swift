//
//  GoalsView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct GoalsView: View {
    @State var goalId = 0
    @State var goals: [GoalModel] = [GoalModel(name: "PSP", goalSum: 50000, level: AimImportantLevels.high, current: 5000, image: "aims_screen_image_selected", date: Date.now)]
    
    var body: some View {
        VStack {
            GoalCardView(goalIndex: $goalId, goals: $goals)
        }
        .frame(width: 0.50 * UIScreen.main.bounds.width)
    }
}

