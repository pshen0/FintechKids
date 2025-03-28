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
    @State private var name: String = ""
    @State private var city: String = ""
    @State private var age: String = ""
    @State private var hobbies: String = ""
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: UIImage?
    @State private var selectedAvatar: String = "person.crop.circle.fill"
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
                    .background(Color.blue.gradient)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        
                        currentAvatar
                        
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.clear)
                    
                    if isEditing {
                        HStack(spacing: 16) {
                            PhotosPicker(selection: $avatarItem, matching: .images) {
                                Label("Фото", systemImage: "photo")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .tint(.gray)
                            
                            Button {
                                showingAvatarPicker.toggle()
                            } label: {
                                Label("Иконки", systemImage: "face.smiling")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .tint(.gray)
                            .sheet(isPresented: $showingAvatarPicker) {
                                AvatarPickerView(selectedAvatar: $selectedAvatar, avatars: systemAvatars)
                                    .onDisappear {
                                        if avatarItem != nil {
                                            avatarImage = nil
                                        }
                                    }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                Section("Основная информация") {
                    TextField("Имя*", text: $name)
                        .disabled(!isEditing)
                    
                    TextField("Возраст*", text: $age)
                        .keyboardType(.numberPad)
                        .disabled(!isEditing)
                }
                
                Section("О себе") {
                    TextField("Хобби и интересы*", text: $hobbies, axis: .vertical)
                        .lineLimit(3...)
                        .disabled(!isEditing)
                }
                
                if isEditing {
                    Section {
                        Button(role: .destructive) {
                            avatarImage = nil
                            selectedAvatar = "person.crop.circle.fill"
                            avatarItem = nil
                        } label: {
                            Label("Сбросить аватарку", systemImage: "trash")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .navigationTitle("Мой профиль")
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
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Готово" : "Изменить") {
                        isEditing.toggle()
                    }
                    .fontWeight(.medium)
                    .disabled(isEditing && !isFormValid)
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
                                .background(LinearGradient(
                                    colors: [Color.blue, Color.purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Готово") {
                        dismiss()
                    }
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
