//
//  ProfileSettingsView.swift
//  FintechKids
//
//  Created by George Petryaev on 03.04.2025.
//

import SwiftUI
import PhotosUI

struct ProfileSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = UserSettingsManager.shared.userName
    @State private var age: String = UserSettingsManager.shared.userAge
    @State private var hobbies: String = UserSettingsManager.shared.userHobbies
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: UIImage?
    @State private var selectedAvatar: String = UserSettingsManager.shared.userAvatar
    @State private var showingAvatarPicker = false
    
    @State private var isEditingAvatar = false
    @State private var editingField: String? = nil
    
    var isFormValid: Bool {
        !name.isEmpty && !age.isEmpty && !hobbies.isEmpty
    }
    
    let systemAvatars = [
        "person.crop.circle.fill",
        "face.smiling.fill",
        "person.fill",
        "person.2.circle.fill",
        "person.3.fill",
        "pawprint.fill",
        "teddybear.fill",
        "fish.fill",
        "hare.fill",
        "lizard.fill"
    ]
    
    var currentAvatar: some View {
        Group {
            if let avatarImage {
                Image(uiImage: avatarImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
            } else if selectedAvatar == "photo" {
                if let savedImageData = UserDefaults.standard.data(forKey: "userAvatarImage"),
                   let savedImage = UIImage(data: savedImageData) {
                    Image(uiImage: savedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(20)
                        .foregroundColor(.white)
                        .background(Color("PrimaryOrange"))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                }
            } else {
                Image(systemName: selectedAvatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(20)
                    .foregroundColor(.white)
                    .background(Color("PrimaryOrange"))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
            }
        }
        .onTapGesture {
            isEditingAvatar = true
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.highlightedBackground, location: 0.2),
                        .init(color: Color.background, location: 0.6),
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Avatar Section
                        VStack {
                            currentAvatar
                                .padding(.top, 20)
                            
                            if isEditingAvatar {
                                HStack(spacing: 16) {
                                    Button {
                                        // Photo picker action
                                    } label: {
                                        Label("Фото", systemImage: "photo")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(SettingsButtonStyle())
                                    .overlay(
                                        PhotosPicker(selection: $avatarItem, matching: .images) {
                                            Color.clear
                                        }
                                    )
                                    
                                    Button {
                                        showingAvatarPicker.toggle()
                                    } label: {
                                        Label("Иконки", systemImage: "face.smiling")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(SettingsButtonStyle())
                                }
                                .padding(.horizontal, 40)
                                .padding(.vertical, 8)
                                
                                Button(role: .destructive) {
                                    avatarImage = nil
                                    selectedAvatar = "person.crop.circle.fill"
                                    avatarItem = nil
                                } label: {
                                    Label("Сбросить аватарку", systemImage: "trash")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(SettingsButtonStyle())
                                .padding(.horizontal, 40)
                                
                                Button {
                                    UserSettingsManager.shared.saveUserData(
                                        name: name,
                                        age: age,
                                        hobbies: hobbies,
                                        avatar: selectedAvatar,
                                        avatarImage: avatarImage
                                    )
                                    isEditingAvatar = false
                                } label: {
                                    Label("Сохранить", systemImage: "checkmark")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(SettingsButtonStyle())
                                .padding(.horizontal, 40)
                            }
                        }
                        
                        // Form Fields
                        VStack(spacing: 15) {
                            EditableField(label: "Имя*", text: $name, isEditing: editingField == "name", fieldType: "name", editingField: $editingField)
                            EditableField(label: "Возраст*", text: $age, isEditing: editingField == "age", fieldType: "age", editingField: $editingField, keyboardType: .numberPad)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Хобби и интересы*")
                                    .font(Font.custom(Fonts.deledda, size: 16))
                                    .foregroundColor(.text)
                                
                                TextEditor(text: $hobbies)
                                    .font(Font.custom(Fonts.deledda, size: 16))
                                    .frame(minHeight: 100)
                                    .padding(10)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(color: .highlightedBackground, radius: 6)
                                    .disabled(editingField != "hobbies")
                                    .onTapGesture {
                                        editingField = "hobbies"
                                    }
                                    .onChange(of: hobbies) { newValue in
                                        UserSettingsManager.shared.saveUserData(
                                            name: UserSettingsManager.shared.userName,
                                            age: UserSettingsManager.shared.userAge,
                                            hobbies: newValue,
                                            avatar: UserSettingsManager.shared.userAvatar,
                                            avatarImage: nil
                                        )
                                    }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .fontWeight(.medium)
                            Text("Назад")
                        }
                    }
                    .font(Font.custom(Fonts.deledda, size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.text)
                }
            }
            .sheet(isPresented: $showingAvatarPicker) {
                AvatarPickerView(selectedAvatar: $selectedAvatar, avatars: systemAvatars)
                    .onDisappear {
                        if avatarItem != nil {
                            avatarImage = nil
                        }
                    }
            }
            .onChange(of: avatarItem) {
                Task {
                    await loadSelectedImage()
                }
            }
        }
    }
    
    @MainActor
    private func loadSelectedImage() async {
        if let data = try? await avatarItem?.loadTransferable(type: Data.self),
           let uiImage = UIImage(data: data) {
            avatarImage = uiImage
            selectedAvatar = "photo"
        }
    }
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
    }
} 
