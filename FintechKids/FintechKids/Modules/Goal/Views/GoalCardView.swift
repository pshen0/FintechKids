//
//  GoalCard.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct GoalCardView: View {
    @StateObject var viewModel: GoalViewModel
    @State private var rotation: Double = -180
    
    var body: some View {
        GeometryReader { size in
            let width = size.size.width
            let height = size.size.height
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.lerp(to: Color.highlightedBackground, from: Color.text, progress: (rotation + 180) / 180))
                    .frame(width: width, height: height)
                
                FrontSideGoalCardView(height: height, width: width, goal: viewModel.goal)
                    .modifier(FlipOpacity(percentage: viewModel.isFlipped ? 0 : 1))
                    .frame(width: width, height: height)
                
                BackSideGoalCardView(viewModel: viewModel, width: width)
                    .frame(width: 0.9 * width, height: 0.8 * height)
                    .modifier(FlipOpacity(percentage: viewModel.isFlipped ? 1 : 0))
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 1.0, y: 0.001, z: 0.001)
                    )
            }
            .rotation3DEffect(.degrees(viewModel.isFlipped ? 180: 360), axis: (1, 0.001, 0.001), perspective: 0.5)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.8)) {
                    // TODO: нужно сделать какую-нить анимацию, чтобы показать пользователю что надо закомитить изменения (тыкнуть галку) перед тем как переворачивать
                    if !viewModel.isEdit {
                        viewModel.isFlipped.toggle()
                        rotation = viewModel.isFlipped ? -180 : 0
                    } else {
                        print("locked")
                    }
                }
            }
        }
    }
}

extension Color {
    static func lerp(to: Color, from: Color, progress: Double) -> Color {
        let fromComponents = UIColor(to).cgColor.components ?? [0, 0, 0, 1]
        let toComponents = UIColor(from).cgColor.components ?? [0, 0, 0, 1]
        
        let r = fromComponents[0] + (toComponents[0] - fromComponents[0]) * progress
        let g = fromComponents[1] + (toComponents[1] - fromComponents[1]) * progress
        let b = fromComponents[2] + (toComponents[2] - fromComponents[2]) * progress
        let a = fromComponents[3] + (toComponents[3] - fromComponents[3]) * progress
        
        return Color(UIColor(red: r, green: g, blue: b, alpha: a))
    }
}
