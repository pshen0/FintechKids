//
//  GoalCard.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct GoalCardView: View {
    var goalIndex: Int
    @State private var isFlipped = false
    @Binding var goals: [GoalModel]
    
    var body: some View {
        GeometryReader { size in
            let width = size.size.width
            let height = size.size.height
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: width, height: height)
                
                FrontSideGoalCardView(height: height, width: width, goal: $goals[goalIndex])
                    .modifier(FlipOpacity(percentage: isFlipped ? 0 : 1))
                    .frame(width: width, height: height)
                
                BackSideGoalCardView(goal: $goals[goalIndex])
                    .modifier(FlipOpacity(percentage: isFlipped ? 1 : 0))
                    .frame(width: 0.9 * width, height: 0.8 * height)
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 1.0, y: 0.0, z: 0.0)
                    )
            }
            .rotation3DEffect(.degrees(isFlipped ? 180: 360), axis: (1, 0, 0), perspective: 0.5)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.8)) {
                    self.isFlipped.toggle()
                }
            }
        }
    }
}
