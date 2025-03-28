//
//  GoalsView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct GoalsView: View {
    @StateObject private var viewModel = GoalsViewModel()
    
    var body: some View {
        VStack {
            GoalCardView(goalIndex: $viewModel.selectedIndex, goals: $viewModel.goals)
        }
        .frame(width: 0.90 * UIScreen.main.bounds.width, height: 0.2 * UIScreen.main.bounds.height)
    }
}

#Preview {
    GoalsView()
}
