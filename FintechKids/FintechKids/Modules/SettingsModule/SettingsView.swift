//
//  SettingsView.swift
//  FintechKids
//
//  Created by George Petryaev on 27.03.2025.
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
    
    @State private var isEditing = false
    
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
                            
                            if isEditing {
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
                                
                                if isEditing {
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
                                }
                            }
                        }
                        
                        // Form Fields
                        VStack(spacing: 15) {
                            CustomTextField(label: "Имя*", text: $name, isEditing: isEditing)
                            CustomTextField(label: "Возраст*", text: $age, isEditing: isEditing, keyboardType: .numberPad)
                            
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
                                    .disabled(!isEditing)
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
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Готово" : "Изменить") {
                        if isEditing && isFormValid {
                            UserSettingsManager.shared.saveUserData(
                                name: name,
                                age: age,
                                hobbies: hobbies,
                                avatar: selectedAvatar
                            )
                        }
                        isEditing.toggle()
                    }
                    .font(Font.custom(Fonts.deledda, size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.text)
                    .disabled(isEditing && !isFormValid)
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

struct CustomTextField: View {
    let label: String
    @Binding var text: String
    var isEditing: Bool
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
        }
        .padding(.horizontal, 20)
    }
}

struct SettingsButtonStyle: ButtonStyle {
    var backgroundColor: Color = .highlightedBackground
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom(Fonts.deledda, size: 18))
            .fontWeight(.bold)
            .foregroundColor(.text)
            .padding()
            .background(backgroundColor)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(color: .highlightedBackground, radius: 6)
    }
}

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

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
    }
}
