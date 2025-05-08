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
    @StateObject var viewModel: GoalViewModel
    @StateObject var goalsViewModel: GoalsViewModel
    
    var body: some View {
        HStack {
            Spacer()
            HStack  {
                CustomProgressView(progress: Double(viewModel.goal.progress) / 100)
                    .frame(width: 0.05 * width, height: height * 0.9)
            }
            .frame(width: width * 0.13, alignment: .trailing)
            .padding()
            ZStack {
                image
                    .frame(width: 0.87 * width, alignment: .leading)
                Spacer()
                star
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .offset(x: -30, y: 20)
                    .font(.system(size: 30))
                
            }
            Spacer()
        }
        .frame(maxWidth: width)
    }
    
    private var star: some View {
        Image(systemName: viewModel.goal.level ? "star.fill": "star")
            .onTapGesture {
                viewModel.objectWillChange.send()
                viewModel.goal.level.toggle()
                goalsViewModel.updateGoal(with: viewModel.id, with: viewModel)
            }
            .foregroundStyle(Color.cardBackSide)
            .zIndex(1)
    }
    
    private var image: some View {
        Image(uiImage: loadSavedImage(imageName: viewModel.goal.image))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width * 0.8, height: height * 0.9)
            .cornerRadius(20)
            .clipped()
    }
}
