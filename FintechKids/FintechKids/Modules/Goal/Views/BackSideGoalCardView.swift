//
//  BackSideGoalCardView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct BackSideGoalCardView: View {
    @StateObject var viewModel: GoalViewModel
    let width: CGFloat
    let formatter = DateFormatter()
    @State private var avatarItem: PhotosPickerItem?
    
    @Namespace private var animationNamespace
    
    var body: some View {
        VStack {
            HStack {
                name
                
                editButtons
            }
            Spacer()
            
            infoStack
            
            Spacer()
        }
    }
    
    private var name: some View {
        CustomtextField(text: $viewModel.name, flag: $viewModel.isEdit, width: width)
            .bold()
    }
    
    private var editButtons: some View {
        HStack {
            switch viewModel.isEdit {
            case false:
                CustomImageEditButton(flag: $viewModel.isEdit, update: viewModel.updateGoal)
                    .matchedGeometryEffect(id: "editButton", in: animationNamespace)
            case true:
                CustomImagePickerView(imageName: viewModel.goal.image)
                CustomImageEditButton(flag: $viewModel.isEdit, update: viewModel.updateGoal)
                    .matchedGeometryEffect(id: "editButton", in: animationNamespace)
            }
        }
    }
    
    private var infoStack: some View {
        VStack(alignment: .leading) {
            Text("Дата: \(String(describing: viewModel.goal.date.formattedDate()))")
                .opacity(viewModel.isEdit ? 0.5 : 1)
            HStack {
                Text("Накоплено: ")
                CustomtextField(text: $viewModel.current, flag: $viewModel.isEdit,  width: nil)
                    .keyboardType(.numberPad)
            }
            HStack {
                Text("Цель: ")
                CustomtextField(text: $viewModel.goalSum, flag: $viewModel.isEdit, width: nil)
                    .keyboardType(.numberPad)
            }
            Text("Прогресс: \(String(describing: viewModel.goal.progress))%")
                .opacity(viewModel.isEdit ? 0.5 : 1)
        }
    }
}

#Preview {
    GoalsView()
}
