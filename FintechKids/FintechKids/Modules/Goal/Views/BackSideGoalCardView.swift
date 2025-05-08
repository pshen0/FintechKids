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
    @StateObject var goalsViewModel: GoalsViewModel
    let contentWidth: CGFloat
    let contentHeight: CGFloat
    
    @State private var avatarItem: PhotosPickerItem?
    
    @Namespace private var animationNamespace
    
    var body: some View {
        VStack {
            Spacer()
            
            name
                .font(Font.custom(Fonts.deledda, size: 30))
                .foregroundColor(Color.text)
                .bold()
            Spacer()
            
            infoStack
                .font(Font.custom(Fonts.deledda, size: 17))
                .foregroundColor(Color.text)
            
            Spacer()
            
            finishButton
            
            Spacer()
        }
    }
    
    private var name: some View {
        CustomtextField(text: $viewModel.name, flag: $viewModel.isEdit, width: contentWidth, placeholder: "Цель")
            .bold()
    }
    
    private var infoStack: some View {
        HStack {
            Spacer()
            VStack {
                CustomtextField(text: $viewModel.current, flag: $viewModel.isEdit,  width: nil, placeholder: "Уже есть")
                    .keyboardType(.numberPad)
                    .font(Font.custom(Fonts.deledda, size: 25))
                    .foregroundColor(Color.text)
                    .bold()
                HStack {
                    Text("из ")
                    CustomtextField(text: $viewModel.goalSum, flag: $viewModel.isEdit, width: nil, placeholder: "Нужно")
                        .keyboardType(.numberPad)
                }
                .foregroundColor(Color.text)
            }
            Spacer()

            VStack {
                if viewModel.isEdit {
                    CustomImagePickerView(imageName: viewModel.goal.image)
                        .frame(width: contentWidth * 0.4, height: contentHeight * 0.3)
                        .clipped()
                        .cornerRadius(20)
                        
                } else {
                    Text("Прогресс \(String(describing: viewModel.goal.progress))%")
                        .opacity(viewModel.isEdit ? 0 : 1)
                    Text(" Дата: \(String(describing: viewModel.goal.date.formattedDate()))")
                        .opacity(viewModel.isEdit ? 0 : 1)
                }
            }
            Spacer()
        }
    }
    
    private var finishButton: some View {
        Button(action: {
            withAnimation {
                if viewModel.isEdit && viewModel.name != "" && Int(viewModel.goalSum) ?? 0 > 1 {
                    viewModel.updateGoal()
                    goalsViewModel.updateGoal(with: viewModel.id, with: viewModel)
                    viewModel.isEdit.toggle()
                } else if !viewModel.isEdit {
                    viewModel.isEdit.toggle()
                }
            }
        }) {
            Text(viewModel.isEdit ? "Завершить": "Редактировать")
                .font(Font.custom(Fonts.deledda, size: 17))
                .padding()
                .frame(width: contentWidth * 0.6)
                .background(Color.highlightedBackground)
                .foregroundColor(Color.text)
                .cornerRadius(20)
            
        }
    }
}
