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
    
    var body: some View {
        VStack {
            Text("Цели")
                .font(.largeTitle)
                .foregroundColor(Color("customBrown"))
                .bold()
                .frame(maxWidth: width * 0.9, alignment: .leading)
            List {
                ForEach(0..<viewModel.goals.count, id: \.self) {i in
                    GoalCardView(goalIndex: i, goals: $viewModel.goals)
                        .swipeActions {
                            Button {
                                viewModel.deleteGoal(at: i)
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                            .tint(.red)
                        }
                }
                .frame(width: 0.9 * width, height: 0.2 * height)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .listStyle(PlainListStyle())
            .listRowSeparator(.hidden)
            .navigationTitle("Цели")
        }
    }
}

#Preview {
    GoalsView()
        .background(Color("backgroundColor"))
}
