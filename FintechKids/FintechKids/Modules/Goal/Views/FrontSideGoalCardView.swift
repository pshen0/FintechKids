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
    var goal: GoalModel
    
    var body: some View {
        ZStack {
            image
            
            progressView
        }
    }
    
    private var image: some View {
        Image(uiImage: loadSavedImage(imageName: goal.image))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: height)
            .cornerRadius(20)
            .clipped()
    }
    
    private var progressView: some View {
        ProgressView(value: Double(goal.progress) / 100)
            .progressViewStyle(ThickLinearProgressViewStyle(height: height * 0.8, width: width * 0.1))
            .frame(width: width * 0.95, alignment: .leading)
    }
}

#Preview {
    GoalsView()
}
