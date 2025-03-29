//
//  GoalCard.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct GoalCardView: View {
    @StateObject var viewModel: GoalViewModel
    @State private var isFlipped = false
    
    var body: some View {
        GeometryReader { size in
            let width = size.size.width
            let height = size.size.height
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: width, height: height)
                
                FrontSideGoalCardView(height: height, width: width, goal: viewModel.$goal)
                    .modifier(FlipOpacity(percentage: isFlipped ? 0 : 1))
                    .frame(width: width, height: height)
                
                BackSideGoalCardView(viewModel: viewModel, width: width)
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
                    // TODO: нужно сделать какую-нить анимацию, чтобы показать пользователю что надо закомитить изменения (тыкнуть галку) перед тем как переворачивать
                    !viewModel.isEdit ? self.isFlipped.toggle(): print("locked")
                }
            }
        }
    }
}
