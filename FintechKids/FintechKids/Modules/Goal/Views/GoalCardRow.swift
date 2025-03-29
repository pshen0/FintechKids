//
//  GoalCardRow.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 29.03.2025.
//

import SwiftUI

struct GoalCardRow: View {
    @StateObject var viewModel: GoalViewModel
    @State var offset: CGFloat = 0
    let height: CGFloat
    let width: CGFloat
    var onDelete: () -> Void
    
    var body: some View {
        GoalCardView(viewModel: viewModel)
            .frame(width: 0.9 * width, height: (viewModel.isEdit ? 0.3: 0.2) * height)
            .offset(x: offset)
            .swipeActions {
                Button {
                    withAnimation(.easeIn(duration: 0.3)) {
                        offset = -UIScreen.main.bounds.width
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            onDelete()
                        }
                    }
                } label: {
                    Image(systemName: "trash.fill")
                }
                .tint(.red)
            }
    }
}
