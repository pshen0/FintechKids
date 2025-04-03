//
//  GoalCardRow.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 29.03.2025.
//

import SwiftUI

struct GoalCardRow: View {
    @StateObject var viewModel: GoalViewModel
    @StateObject var goalsViewModel: GoalsViewModel
    @State private var offset: CGFloat = 0
    @State private var showDelete: Bool = false
    let height: CGFloat
    let width: CGFloat
    var onDelete: () -> Void
    private let deleteWidth: CGFloat = 100
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if showDelete {
                deleteBackground
            }
            goalCardView
        }
        .animation(.easeInOut(duration: 0.2), value: showDelete)
    }
    
    private var goalCardView: some View {
        GoalCardView(viewModel: viewModel, goalsViewModel: goalsViewModel)
            .frame(width: 0.9 * width, height: (viewModel.isEdit ? 0.3: 0.2) * height)
            .offset(x: offset)
            .shadow(radius: 5)
            .gesture(
                DragGesture(minimumDistance: 30)
                    .onChanged { gesture in
                        let translation = gesture.translation.width
                        if translation < -10 {
                            offset = max(translation, -deleteWidth)
                        }
                    }
                    .onEnded { gesture in
                        let predictedOffset = gesture.predictedEndTranslation.width
                        if predictedOffset < -deleteWidth / 2 {
                            withAnimation {
                                offset = -deleteWidth
                                showDelete = true
                            }
                        } else {
                            withAnimation {
                                offset = 0
                                showDelete = false
                            }
                        }
                    }
            )
    }
    
    private var deleteBackground: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                offset = -width
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                onDelete()
            }
        }) {
            Image(systemName: "trash.fill")
                .foregroundColor(.white)
                .frame(width: deleteWidth, height: (viewModel.isEdit ? 0.3 : 0.2) * height)
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
