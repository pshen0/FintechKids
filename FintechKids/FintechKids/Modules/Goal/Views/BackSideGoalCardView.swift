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
    let contentWidth: CGFloat
    
    @State private var avatarItem: PhotosPickerItem?
    
    @Namespace private var animationNamespace
    
    var body: some View {
        VStack {
            HStack {
                name
                    .font(Font.custom(Fonts.deledda, size: 30))
                    .foregroundColor(Color.text)
                    .bold()
                
                editButtons
            }
            Spacer()
            
            infoStack
                .font(Font.custom(Fonts.deledda, size: 15))
                .foregroundColor(Color.text)
            
            Spacer()
        }
    }
    
    private var name: some View {
        CustomtextField(text: $viewModel.name, flag: $viewModel.isEdit, width: contentWidth)
            .bold()
    }
    
    private var editButtons: some View {
        HStack {
            switch viewModel.isEdit {
            case false:
                editButton
            case true:
                CustomImagePickerView(imageName: viewModel.goal.image)
                editButton
            }
        }
    }
    
    private var editButton: some View {
        CustomImageEditButton(flag: $viewModel.isEdit, update: viewModel.updateGoal)
            .matchedGeometryEffect(id: "editButton", in: animationNamespace)
    }
    
    private var infoStack: some View {
        HStack {
            VStack {
                CustomtextField(text: $viewModel.current, flag: $viewModel.isEdit,  width: nil)
                    .keyboardType(.numberPad)
                    .font(Font.custom(Fonts.deledda, size: 40))
                    .foregroundColor(Color.text)
                    .bold()
                HStack {
                    Text("из ")
                    CustomtextField(text: $viewModel.goalSum, flag: $viewModel.isEdit, width: nil)
                        .keyboardType(.numberPad)
                }
                .font(Font.custom(Fonts.deledda, size: 20))
                .foregroundColor(Color.text)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            VStack(alignment: .leading) {
                Text("Прогресс: \(String(describing: viewModel.goal.progress))%")
                    .opacity(viewModel.isEdit ? 0.5 : 1)
                HStack {
                    Text("Приоритет: ")
                    CustomDropDownList(values: [.low, .mid, .high], current: viewModel.goal.level, flag: viewModel.isEdit)
                        .zIndex(1)
                }
                Text("Дата: \(String(describing: viewModel.goal.date.formattedDate()))")
                    .opacity(viewModel.isEdit ? 0.5 : 1)
            }
        }
    }
}

#Preview {
    GoalsView()
}

