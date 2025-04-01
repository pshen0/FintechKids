//
//  AnalyticsView.swift
//  FintechKids
//
//  Created by Анна Сазонова on 26.03.2025.
//

import SwiftUI

struct StartAnalyticsView: View {
    
    @State private var showAddingExpenseScreen = false
    @State private var showDocumentPicker = false
    @State private var unloadRequest = ""
    @State private var charIndex = 0
    @State private var selectedFileURL: URL?
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            gradient
            VStack {
                screenName
                Spacer()
                documentPickButton
                addingExpenseButton
                Spacer()
                HStack {
                    Spacer()
                    catImage
                    ZStack {
                        speechImage
                        unloadText
                    }
                    .padding(.trailing, 20)
                    .frame(width: 250, height: 300)
                    Spacer()
                }
                .padding(.bottom, -30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    
    private var screenName: some View {
        Text(screenNameText)
            .font(Font.custom(Fonts.deledda, size: screenNameSize))
            .padding()
            .foregroundColor(Color.text)
    }
    
    private var documentPickButton: some View {
        Button(action: {
            showDocumentPicker = true
        }) {
            Text(addingFileText)
                .font(Font.custom(Fonts.deledda, size: buttonTextSize))
                .padding(.vertical, buttonVPadding)
                .frame(width: buttonWidth)
                .background(Color.highlightedBackground)
                .foregroundColor(Color.text)
                .cornerRadius(buttonCornerRadius)
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker { url in
                selectedFileURL = url
                showDocumentPicker = false
            }
        }
        .shadow(color: Color.highlightedBackground, radius: shadowButtonRadius)
    }
    
    private var addingExpenseButton: some View {
        Button(action: {
            showAddingExpenseScreen = true
        }) {
            Text(addingExpenseText)
                .font(Font.custom(Fonts.deledda, size: buttonTextSize))
                .padding(.vertical, buttonVPadding)
                .frame(width: buttonWidth)
                .background(Color.highlightedBackground)
                .foregroundColor(Color.text)
                .cornerRadius(buttonCornerRadius)
        }
        .sheet(isPresented: $showAddingExpenseScreen) {
            AddingExpensesView()
        }
        .shadow(color: Color.highlightedBackground, radius: shadowButtonRadius)
    }
    
    private var catImage: some View {
        Image(catImageName)
            .resizable()
            .scaledToFit()
            .frame(width: catWidth, height: catHeight)
            .padding(.leading, catLPadding)
    }
    
    private var speechImage: some View {
        Image(speechImageName)
            .resizable()
            .scaledToFit()
            .frame(height: speechHeight)
            .padding(.trailing, 20)
    }
    
    private var unloadText: some View {
        Text(unloadRequestText)
            .font(Font.custom(Fonts.deledda, size: 15))
            .foregroundColor(Color.text)
            .padding(.trailing, 20)
            .multilineTextAlignment(.center)
            .padding(.leading, 8.5)
            .onAppear {
                startTypingAnimation()
            }
    }
    
    private func startTypingAnimation() {
        unloadRequest = ""
        charIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: typingAnimationDuration, repeats: true) { timer in
            if charIndex < unloadRequestText.count {
                let index = unloadRequestText.index(unloadRequestText.startIndex, offsetBy: charIndex)
                unloadRequest.append(unloadRequestText[index])
                charIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    private let screenNameText: String = " Аналитика трат "
    private let addingFileText: String = "Добавить выгрузку трат"
    private let addingExpenseText: String = "Добавить новую трату"
    private let unloadRequestText: String = "Чтобы начать отслеживать финансы, необходимо выгрузить траты"
    
    private let catImageName: String = "cat"
    private let speechImageName: String = "speech"
    
    private let screenNameSize: CGFloat = 40
    private let buttonTextSize: CGFloat = 17
    private let buttonCornerRadius: CGFloat = 100
    private let buttonVPadding: CGFloat = 15
    private let catWidth: CGFloat = 126
    private let catHeight: CGFloat = 157
    private let catLPadding: CGFloat = 20
    private let speechHeight: CGFloat = 93
    private let buttonWidth: CGFloat = 250
    private let shadowButtonRadius: CGFloat = 6
    private let typingAnimationDuration: Double = 0.03
}

#Preview {
    StartAnalyticsView()
}
