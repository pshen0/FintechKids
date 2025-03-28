//
//  FrontSideGoalCardView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct FrontSideGoalCardView: View {
    let height: CGFloat
    let width: CGFloat
    @Binding var goal: GoalModel
    
    var body: some View {
        ZStack {
            Image(goal.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: height)
                .cornerRadius(20)
                .clipped()
            ProgressView(value: Double(goal.progress) / 100)
                .progressViewStyle(ThickLinearProgressViewStyle(height: height * 0.8, width: width * 0.1))
                .frame(width: width * 0.95, alignment: .leading)
        }
    }
}

#Preview {
    GoalsView()
}
