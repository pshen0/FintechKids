//
//  BackSideGoalCardView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct BackSideGoalCardView: View {
    @StateObject var viewModel: GoalViewModel
    let width: CGFloat
    let formatter = DateFormatter()
    
    @Namespace private var animationNamespace
    
    var body: some View {
        VStack {
            HStack {
                CustomtextField(text: $viewModel.name, flag: $viewModel.isEdit, width: width)
                    .bold()
                    .animation(.easeInOut(duration: 0.3), value: viewModel.isEdit)
                
                switch viewModel.isEdit {
                case false:
                    CustomImageEditButton(flag: $viewModel.isEdit, update: viewModel.updateGoal)
                        .matchedGeometryEffect(id: "editButton", in: animationNamespace)
                case true:
                    CustomImageEditButton(flag: $viewModel.isEdit, update: viewModel.updateGoal)
                        .matchedGeometryEffect(id: "editButton", in: animationNamespace)
                }
                
                
                
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Дата: \(String(describing: viewModel.goal.date.formattedDate()))")
                    .opacity(viewModel.isEdit ? 0.5 : 1)
                HStack {
                    Text("Накоплено: ")
                    CustomtextField(text: $viewModel.current, flag: $viewModel.isEdit, /*font: $font,*/ width: .infinity)
                }
                HStack {
                    Text("Цель: ")
                    CustomtextField(text: $viewModel.goalSum, flag: $viewModel.isEdit, /*font: $font,*/ width: .infinity)
                }
                Text("Прогресс: \(String(describing: viewModel.goal.progress))%")
                    .opacity(viewModel.isEdit ? 0.5 : 1)
            }
            
            Spacer()
        }
    }
}

#Preview {
    GoalsView()
}
