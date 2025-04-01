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
    @State private var showDelete: Bool = false
    let height: CGFloat
    let width: CGFloat
    var onDelete: () -> Void
    private let deleteOffset: CGFloat = -40
    
    var body: some View {
        HStack {
            goalCardView
            if showDelete {
                deleteBackground
            }
        }
    }
    
    private var goalCardView: some View { 
        GoalCardView(viewModel: viewModel)
            .frame(width: 0.9 * width, height: (viewModel.isEdit ? 0.3: 0.2) * height)
            .offset(x: offset)
            .shadow(radius: 5)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 0 {
                            offset = gesture.translation.width
                            showDelete = true
                        }
                    }
                    .onEnded { gesture in
                        if gesture.translation.width < -100 {
                            withAnimation(.easeIn(duration: 0.6)) {
                                offset = -UIScreen.main.bounds.width
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation {
                                    onDelete()
                                }
                            }
                        } else if gesture.translation.width < -40 {
                            withAnimation(.easeOut) {
                                offset = deleteOffset
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
            withAnimation(.easeIn(duration: 0.3)) {
                offset = -UIScreen.main.bounds.width
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    onDelete()
                }
            }
        }) {
            Image(systemName: "trash.fill")
                .foregroundColor(.white)
                .frame(width: 60, height: (viewModel.isEdit ? 0.3 : 0.2) * height)
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .transition(.move(edge: .trailing))
    }
}
