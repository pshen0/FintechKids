//
//  AvatarPickerView.swift
//  FintechKids
//
//  Created by George Petryaev on 03.04.2025.
//

import SwiftUI

struct AvatarPickerView: View {
    @Binding var selectedAvatar: String
    let avatars: [String]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 20) {
                    ForEach(avatars, id: \.self) { avatar in
                        Button {
                            selectedAvatar = avatar
                            dismiss()
                        } label: {
                            Image(systemName: avatar)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding(20)
                                .foregroundColor(.white)
                                .background(Color("PrimaryOrange"))
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(selectedAvatar == avatar ? Color.white : Color.clear, lineWidth: 3)
                                )
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Выберите аватарку")
            .font(Font.custom(Fonts.deledda, size: 20))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Готово") {
                        dismiss()
                    }
                    .font(Font.custom(Fonts.deledda, size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.text)
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
} 
