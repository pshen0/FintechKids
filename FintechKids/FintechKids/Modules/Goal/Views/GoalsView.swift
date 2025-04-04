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
    
    @Namespace private var namespace
    
    var body: some View {
        ZStack {
            CustomGradient()
            VStack {
                header
                scrollGoals
            }
        }
//        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private var header: some View {
        HStack {
            Text("Цели")
            Spacer()
            buttonForAdding
        }
        .frame(width: width * 0.9)
        .font(Font.custom(Fonts.deledda, size: 40))
        .foregroundColor(Color.text)
        .background(.clear)
    }
    
    private var scrollGoals: some View {
        ScrollView {
            LazyVStack {
                ForEach($viewModel.goalViewModels.sorted(by: {$0.goal.level.wrappedValue && !$1.goal.level.wrappedValue}), id: \.id) { $goal in
                    GoalCardRow(viewModel: goal, goalsViewModel: viewModel, height: height, width: width) {
                        viewModel.deleteGoal(at: goal.id)
                    }
                    .transition(.scale.combined(with: .opacity))
                }
                .frame(width: width)
                .offset(y: 20)
            }
        }
    }
    
    private var buttonForAdding: some View {
        Image(systemName: "plus")
            .onTapGesture {
                    let goal = GoalViewModel(id: viewModel.currentID, goal: GoalModel(), isEdit: true, isFlipped: true)
                withAnimation {
                    viewModel.addNew(goal: goal)
                }
            }
    }
}

#Preview {
    GoalsView()
        .background(Color.background)
}
