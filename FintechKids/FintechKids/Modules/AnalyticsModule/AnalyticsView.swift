//
//  AnalyticsView.swift
//  FintechKids
//
//  Created by Анна Сазонова on 26.03.2025.
//

import SwiftUI

struct AnalyticsView: View {
    
    enum Constants {
        static let screenNameText: String = "Аналитика трат"
        static let addingFileText: String = "Добавить выгрузку трат"
        static let addingExpenseText: String = "Добавить новую трату"
        static let unloadRequestText: String = "Чтобы начать отслеживать финансы, необходимо выгрузить траты"
        
        static let catImageName: String = "cat"
        static let speechImageName: String = "speech"
        
        static let buttonTextSize: CGFloat = 17
        static let buttonCornerRadius: CGFloat = 100
        static let buttonHPadding: CGFloat = 40
        static let buttonVPadding: CGFloat = 15
        static let catWidth: CGFloat = 126
        static let catHeight: CGFloat = 157
        static let catLPadding: CGFloat = 20
        static let speechHeight: CGFloat = 93
    }
    
    
    @State private var showAddingExpenseScreen = false
    @State private var showDocumentPicker = false
    @State private var unloadRequestText = ""
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
        Text(Constants.screenNameText)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
            .foregroundColor(Color.text)
    }
    
    private var documentPickButton: some View {
        Button(action: {
            showDocumentPicker = true
        }) {
            Text(Constants.addingFileText)
                .font(.system(size: Constants.buttonTextSize, weight: .bold))
                .padding(.vertical, Constants.buttonVPadding)
                .frame(width: 250)
                .background(Color.highlightedBackground)
                .foregroundColor(Color.text)
                .cornerRadius(Constants.buttonCornerRadius)
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker { url in
                selectedFileURL = url
                showDocumentPicker = false
            }
        }
    }
    
    private var addingExpenseButton: some View {
        Button(action: {
            showAddingExpenseScreen = true
        }) {
            Text(Constants.addingExpenseText)
                .font(.system(size: Constants.buttonTextSize, weight: .bold))
                .padding(.vertical, Constants.buttonVPadding)
                .frame(width: 250)
                .background(Color.highlightedBackground)
                .foregroundColor(Color.text)
                .cornerRadius(Constants.buttonCornerRadius)
        }
        .sheet(isPresented: $showAddingExpenseScreen) {
            AddingExpensesView()
        }
    }
    
    private var catImage: some View {
        Image(Constants.catImageName)
            .resizable()
            .scaledToFit()
            .frame(width: Constants.catWidth, height: Constants.catHeight)
            .padding(.leading, Constants.catLPadding)
    }
    
    private var speechImage: some View {
        Image(Constants.speechImageName)
            .resizable()
            .scaledToFit()
            .frame(height: Constants.speechHeight)
            .padding(.trailing, 20)
    }
    
    private var unloadText: some View {
        Text(unloadRequestText)
            .font(.system(size: 15, weight: .light))
            .foregroundColor(Color.text)
            .padding(.trailing, 20)
            .multilineTextAlignment(.center)
            .padding(.leading, 8.5)
            .onAppear {
                startTypingAnimation()
            }
    }
    
    func startTypingAnimation() {
        unloadRequestText = ""
        charIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            if charIndex < Constants.unloadRequestText.count {
                let index = Constants.unloadRequestText.index(Constants.unloadRequestText.startIndex, offsetBy: charIndex)
                unloadRequestText.append(Constants.unloadRequestText[index])
                charIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
}




#Preview {
    AnalyticsView()
}
