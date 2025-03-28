//
//  HomeView.swift
//  FintechKids
//
//  Created by Анна Сазонова on 27.03.2025.
//

import SwiftUI

struct HomeView: View {
    enum Constants {
        static let buttonTextSize: CGFloat = 17
        static let buttonVPadding: CGFloat = 15
        static let buttonCornerRadius: CGFloat = 100
        
        static let brown: Color = Color(red: 89/255, green: 51/255, blue: 22/255)
        static let beige: Color = Color(red: 255/255, green: 246/255, blue: 235/255)
        static let lightBeige: Color = Color(red: 249/255, green: 220/255, blue: 184/255)
    }
    
    @State var showChat: Bool = false
    @State var showGame: Bool = false
    @State var showProfile: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            CustomButton(title: "Чат с Фиником", isPresented: $showChat, destination: ChatScreen(viewModel: ChatViewModel()))
            CustomButton(title: "Игра с карточками", isPresented: $showGame, destination: CardGameView())
            CustomButton(title: "Профиль", isPresented: $showProfile, destination: ProfileSettingsView())
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
