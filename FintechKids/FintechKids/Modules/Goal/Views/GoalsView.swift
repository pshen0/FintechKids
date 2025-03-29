//
//  GoalsView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct GoalsView: View {
    @StateObject private var viewModel = GoalsViewModel()
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    @State var offset: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Цели")
                .font(.largeTitle)
                .foregroundColor(Color("customBrown"))
                .bold()
                .frame(maxWidth: width * 0.9, alignment: .leading)
            List {
                ForEach($viewModel.goals, id: \.id) { $goal in
                    GoalCardRow(viewModel: GoalViewModel(goal: $goal), height: height, width: width) {
                        viewModel.deleteGoal(at: goal.id)
                    }
                }

                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    GoalsView()
        .background(Color("backgroundColor"))
}
