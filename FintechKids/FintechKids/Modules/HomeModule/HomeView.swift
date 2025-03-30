//
//  HomeView.swift
//  FintechKids
//
//  Created by Анна Сазонова on 27.03.2025.
//

import SwiftUI

struct HomeView: View {
    enum Constants {
        static let greetingTextSize: CGFloat = 35
        static let buttonTextSize: CGFloat = 17
        static let buttonCornerRadius: CGFloat = 20
        static let buttonHeight: CGFloat = 150
        static let buttonWidth: CGFloat = 150
        static let profileHeight: CGFloat = 40
        static let profileWidth: CGFloat = 40
        static let catWidth: CGFloat = 135
        static let catHeight: CGFloat = 231
        static let catLPadding: CGFloat = 20
    }
    
    @ObservedObject var viewModel: CardGameViewModel
    @State var showChat: Bool = false
    @State var showGame: Bool = false
    @State var showProfile: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient (
                    gradient: Gradient(stops: [
                        .init(color: Color.highlightedBackground, location: 0.2),
                        .init(color: Color.background, location: 0.6),
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()
                VStack {
                    catView
                    greetingView
                    HStack {
                        Spacer()
                        chatButton
                        Spacer()
                        gameButton
                        Spacer()
                    }.padding(.top, 30)
                    Spacer()
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    profileButton
                })
            }
        }
    }
    
    private var profileButton: some View {
        Button(action: {
            showProfile = true
        }) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFit()
                .frame(width: Constants.profileWidth, height: Constants.profileHeight)
                .tint(Color.text)
        }
        .fullScreenCover(isPresented: $showProfile) {
            ProfileSettingsView()
                .interactiveDismissDisabled(true)
        }
    }
    
    private var chatButton: some View {
        Button(action: {
            showChat = true
        }) {
            VStack {
                Text("Чат с Фиником")
                    .font(Font.custom("DeleddaOpen-Light", size: HomeView.Constants.buttonTextSize))
                    .fontWeight(.bold)
                    .foregroundColor(Color.text)
                    .frame(width: Constants.buttonWidth / 1.5)
                    .padding(.top, 20)
                Spacer()
                Image("catChat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.buttonWidth / 1.5)
                    .padding(.bottom, 20)
            }
            .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
            .background(Color.highlightedBackground)
            .cornerRadius(Constants.buttonCornerRadius)
        }
        .fullScreenCover(isPresented: $showChat) {
            ChatScreen(viewModel: ChatViewModel())
                .interactiveDismissDisabled(true)
        }
    }
    
    private var gameButton: some View {
        Button(action: {
            showGame = true
        }) {
            VStack {
                Text("Игра \"Карточки\"")
                    .font(.system(size: Constants.buttonTextSize, weight: .bold))
                    .foregroundColor(Color.text)
                    .frame(width: Constants.buttonWidth / 1.5)
                    .padding(.top, 20)
                Spacer()
                Image("catCards")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.buttonWidth / 2.5)
                    .padding(.bottom, 20)
            }
            .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
            .background(Color.highlightedBackground)
            .cornerRadius(Constants.buttonCornerRadius)
        }
        .fullScreenCover(isPresented: $showGame) {
            CardGameView(viewModel: viewModel)
                .interactiveDismissDisabled(true)
        }
    }
    
    private var catView: some View {
        Image("cat")
            .resizable()
            .scaledToFit()
            .frame(width: Constants.catWidth, height: Constants.catHeight)
            .padding(.top, 80)
    }
    
    private var greetingView: some View {
        VStack(alignment: .leading) {
            Text("Привет!")
                .font(.system(size: Constants.greetingTextSize, weight: .bold))
                .foregroundColor(Color.text)
            Text("Выбери, чем хочешь сегодня заняться:")
                .font(.system(size: Constants.buttonTextSize, weight: .bold))
                .foregroundColor(Color.text)
        }
    }
}
