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
    
    @ObservedObject private var viewModel: CardGameViewModel
    @ObservedObject var screenFactory: ScreenFactory
    
    init(screen: Screen, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.viewModel = CardGameViewModel(screen: screen, screenFactory: screenFactory)
       }

    @State var showChat: Bool = false
    @State var showGame: Bool = false
    @State var showProfile: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                gradient
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
    
    private var gradient: some View {
        LinearGradient (
            gradient: Gradient(stops: [
                .init(color: Color.highlightedBackground, location: 0.2),
                .init(color: Color.background, location: 0.6),
            ]),
            startPoint: .top,
            endPoint: .bottom
        ).ignoresSafeArea()
    }
    
    private var profileButton: some View {
        Button(action: {
            showProfile = true
        }) {
            Image(systemName: profileImage)
                .resizable()
                .scaledToFit()
                .frame(width: profileWidth, height: profileHeight)
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
                Text(chatButtonText)
                    .font(Font.custom(Fonts.deledda, size: buttonTextSize))
                    .fontWeight(.bold)
                    .foregroundColor(Color.text)
                    .frame(width: buttonWidth / 1.5)
                    .padding(.top, buttonTPadding)
                Spacer()
                Image(chatButtonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonWidth / 1.5)
                    .padding(.bottom, buttonBPadding)
            }
            .frame(width: buttonWidth, height: buttonHeight)
            .background(Color.highlightedBackground)
            .cornerRadius(buttonCornerRadius)
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
                Text(gameButtonText)
                    .font(Font.custom(Fonts.deledda, size: buttonTextSize))
                    .foregroundColor(Color.text)
                    .frame(width: buttonWidth / 1.5)
                    .padding(.top, buttonTPadding)
                Spacer()
                Image(gameButtonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonWidth / 2.5)
                    .padding(.bottom, buttonBPadding)
            }
            .frame(width: buttonWidth, height: buttonHeight)
            .background(Color.highlightedBackground)
            .cornerRadius(buttonCornerRadius)
        }
        .fullScreenCover(isPresented: $showGame) {
            CardGameView(viewModel: viewModel)
                .interactiveDismissDisabled(true)
        }
    }
    
    private var catView: some View {
        Image(catImage)
            .resizable()
            .scaledToFit()
            .frame(width: catWidth, height: catHeight)
            .padding(.top, catTPadding)
    }
    
    private var greetingView: some View {
        VStack(alignment: .leading) {
            Text(greetingText1)
                .font(Font.custom(Fonts.deledda, size: greetingTextSize))
                .foregroundColor(Color.text)
                .padding(.bottom, greetingBPadding)
            Text(greetingText2)
                .font(Font.custom(Fonts.deledda, size: buttonTextSize))
                .foregroundColor(Color.text)
        }
    }
    
    //MARK: - Constants
    
    private let profileImage: String = "person.crop.circle"
    private let chatButtonText: String = "Чат с Фиником"
    private let chatButtonImage: String = "catChat"
    private let gameButtonText: String = "Игра \"Карточки\""
    private let gameButtonImage: String = "catCards"
    private let catImage: String = "cat"
    private let greetingText1: String = "Привет!"
    private let greetingText2: String = "Выбери, чем хочешь сегодня заняться:"
    
    private let greetingTextSize: CGFloat = 40
    private let greetingBPadding: CGFloat = 5
    private let buttonTextSize: CGFloat = 18
    private let buttonCornerRadius: CGFloat = 20
    private let buttonBPadding: CGFloat = 20
    private let buttonTPadding: CGFloat = 20
    private let buttonHeight: CGFloat = 150
    private let buttonWidth: CGFloat = 150
    private let profileHeight: CGFloat = 40
    private let profileWidth: CGFloat = 40
    private let catWidth: CGFloat = 135
    private let catHeight: CGFloat = 231
    private let catLPadding: CGFloat = 20
    private let catTPadding: CGFloat = 80
}

