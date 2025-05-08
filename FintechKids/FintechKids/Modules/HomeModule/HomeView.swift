//
//  HomeView.swift
//  FintechKids
//
//  Created by Анна Сазонова on 27.03.2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @ObservedObject private var viewModel: CardGameViewModel
    @ObservedObject var screenFactory: ScreenFactory
    @StateObject private var settingsManager = UserSettingsManager.shared
    
    init(screen: Screen, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.viewModel = CardGameViewModel(screen: screen, screenFactory: screenFactory)
    }

    @State var showChat: Bool = false
    @State var showCardGame: Bool = false
    @State var showShoppingGame: Bool = false
    @State var showProfile: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainBGGradient()
                BubbleAnimationView()
                    .padding(.top, -100)
                VStack {
                    Spacer()
                    catView
                    greetingView
                    HStack {
                        Spacer()
                        chatButton
                        Spacer()
                        cardGameButton
                        Spacer()
                        shoppingGameButton
                        Spacer()
                    }
                    Spacer()
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
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
            if settingsManager.userAvatar == "photo" {
                if let uiImage = settingsManager.currentAvatarImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: profileWidth, height: profileHeight)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: profileWidth, height: profileHeight)
                        .tint(Color.text)
                }
            } else {
                ZStack {
                    Circle()
                        .fill(Color("PrimaryOrange"))
                        .frame(width: profileWidth, height: profileHeight)
                    
                    Image(systemName: settingsManager.userAvatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: profileWidth - 16, height: profileHeight - 16)
                        .clipShape(Circle())
                }
                .frame(width: profileWidth, height: profileHeight)
                .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                .foregroundColor(.white)
            }
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
                    .multilineTextAlignment(.center)
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
            if case let .chatScreen(chatViewModel) = screenFactory.createScreen(ofType: .chat) {
                ChatScreen(viewModel: chatViewModel)
            }
        }
        .shadow(color: Color.highlightedBackground, radius: shadowButtonRadius)
    }
    
    private var cardGameButton: some View {
        Button(action: {
            showCardGame = true
        }) {
            VStack {
                Text(cardsGameButtonText)
                    .font(Font.custom(Fonts.deledda, size: buttonTextSize))
                    .foregroundColor(Color.text)
                    .multilineTextAlignment(.center)
                    .frame(width: buttonWidth / 1.5)
                    .padding(.top, buttonTPadding)
                Spacer()
                Image(cardsGameButtonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonWidth / 2.5)
                    .padding(.bottom, buttonBPadding)
            }
            .frame(width: buttonWidth, height: buttonHeight)
            .background(Color.highlightedBackground)
            .cornerRadius(buttonCornerRadius)
        }
        .fullScreenCover(isPresented: $showCardGame) {
            CardGameView(viewModel: viewModel)
                .interactiveDismissDisabled(true)
        }
        .shadow(color: Color.highlightedBackground, radius: shadowButtonRadius)
    }
    
    private var shoppingGameButton: some View {
        Button(action: {
            showShoppingGame = true
        }) {
            VStack {
                Text(shoppingGameButtonText)
                    .font(Font.custom(Fonts.deledda, size: buttonTextSize))
                    .foregroundColor(Color.text)
                    .multilineTextAlignment(.center)
                    .frame(width: buttonWidth / 1.5)
                    .padding(.top, buttonTPadding)
                Spacer()
                Image(shoppingGameButtonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonWidth / 1.5)
                    .padding(.bottom, buttonBPadding)
            }
            .frame(width: buttonWidth, height: buttonHeight)
            .background(Color.highlightedBackground)
            .cornerRadius(buttonCornerRadius)
        }
        .fullScreenCover(isPresented: $showShoppingGame) {
            ShoppingGameView(viewModel: ShoppingGameViewModel())
                .interactiveDismissDisabled(true)
        }
        .shadow(color: Color.highlightedBackground, radius: shadowButtonRadius)
    }
    
    private var catView: some View {
        Image(catImage)
            .resizable()
            .scaledToFit()
            .frame(width: catWidth, height: catHeight)
            //.padding(.top, catTPadding)
    }
    
    private var greetingView: some View {
        VStack(alignment: .leading) {
            Text(greetingText1)
                .font(Font.custom(Fonts.deledda, size: greetingTextSize1))
                .foregroundColor(Color.text)
                .padding(.bottom, greetingBPadding)
            Text(greetingText2)
                .font(Font.custom(Fonts.deledda, size: greetingTextSize2))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.text)
        }
    }
    
    //MARK: - Constants
    
    private let profileImage: String = "person.crop.circle"
    private let chatButtonText: String = "Чат с Фиником"
    private let chatButtonImage: String = "catChat"
    private let cardsGameButtonText: String = "Игра Карточки"
    private let shoppingGameButtonText: String = "Игра Покупки"
    private let cardsGameButtonImage: String = "catCards"
    private let shoppingGameButtonImage: String = "catShopping"
    private let catImage: String = "cat"
    private let greetingText1: String = "Привет!"
    private let greetingText2: String = "Выбери, чем хочешь сегодня заняться:"
    
    private let greetingTextSize1: CGFloat = 40
    private let greetingTextSize2: CGFloat = 20
    private let greetingBPadding: CGFloat = 5
    private let buttonTextSize: CGFloat = 14
    private let buttonCornerRadius: CGFloat = 20
    private let buttonBPadding: CGFloat = 20
    private let buttonTPadding: CGFloat = 20
    private let buttonHeight: CGFloat = 140
    private let buttonWidth: CGFloat = 110
    private let profileHeight: CGFloat = 40
    private let profileWidth: CGFloat = 40
    private let catWidth: CGFloat = 135
    private let catHeight: CGFloat = 231
    private let catLPadding: CGFloat = 20
    //private let catTPadding: CGFloat = 80
    private let shadowButtonRadius: CGFloat = 6
}

#Preview {
    HomeView(screen: .analytics, screenFactory: ScreenFactory())
}

