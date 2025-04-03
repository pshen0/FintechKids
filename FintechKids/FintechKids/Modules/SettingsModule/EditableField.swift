//
//  EditableField.swift
//  FintechKids
//
//  Created by George Petryaev on 03.04.2025.
//

import SwiftUI

struct EditableField: View {
    let label: String
    @Binding var text: String
    var isEditing: Bool
    let fieldType: String
    @Binding var editingField: String?
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(Font.custom(Fonts.deledda, size: 16))
                .foregroundColor(.text)
            
            TextField("", text: $text)
                .font(Font.custom(Fonts.deledda, size: 15))
                .fontWeight(.medium)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .highlightedBackground, radius: 6)
                .disabled(!isEditing)
                .keyboardType(keyboardType)
                .onTapGesture {
                    if !isEditing {
                        editingField = fieldType
                    }
                }
                .onChange(of: text) { newValue in
                    UserSettingsManager.shared.saveUserData(
                        name: fieldType == "name" ? newValue : UserSettingsManager.shared.userName,
                        age: fieldType == "age" ? newValue : UserSettingsManager.shared.userAge,
                        hobbies: fieldType == "hobbies" ? newValue : UserSettingsManager.shared.userHobbies,
                        avatar: UserSettingsManager.shared.userAvatar,
                        avatarImage: nil
                    )
                }
        }
        .padding(.horizontal, 20)
    }
} 
