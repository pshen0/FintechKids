//
//  GoalCard.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct GoalCardView: View {
    @Binding var goalIndex: Int
    @State private var isFlipped = false
    @State private var animate3d = false
    
    // Это заглушка, надо поменять на какое-нить локальное хранение типа SwiftData и по id передавать
    @Binding var goals: [GoalModel]
    
    var body: some View {
        GeometryReader { size in
            let width = size.size.width
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: width * 0.95, height: width * 0.95)
                
                FrontSideGoalCardView(width: width, image: goals[goalIndex].image)
                    .modifier(FlipOpacity(percentage: isFlipped ? 0 : 1))
                
                BackSideGoalCardView(width: width, goal: $goals[goalIndex])
                    .modifier(FlipOpacity(percentage: isFlipped ? 1 : 0))
            }
            .rotation3DEffect(.degrees(isFlipped ? 0: 180), axis: (0, 1, 0), perspective: 0.5)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.8)) {
                    self.isFlipped.toggle()
                }
            }
        }
    }
}

enum AimImportantLevels {
    case high
    case mid
    case low
}
