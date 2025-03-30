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
        static let speachImageName: String = "speech"
        
        static let buttonTextSize: CGFloat = 17
        static let buttonCornerRadius: CGFloat = 100
        static let buttonHPadding: CGFloat = 40
        static let buttonVPadding: CGFloat = 15
        static let catWidth: CGFloat = 126
        static let catHeight: CGFloat = 157
        static let catLPadding: CGFloat = 20
        static let speachHeight: CGFloat = 93
        
        static let brown: Color = Color(red: 89/255, green: 51/255, blue: 22/255)
        static let beige: Color = Color(red: 255/255, green: 246/255, blue: 235/255)
        static let lightBeige: Color = Color(red: 249/255, green: 220/255, blue: 184/255)
    }
    
    
    @State private var showAddingExpenseScreen = false
    @State private var showDocumentPicker = false
    @State private var unloadRequestText = ""
    @State private var charIndex = 0
    @State private var selectedFileURL: URL?
    
    var body: some View {
        VStack {
            Text(Constants.screenNameText)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(Constants.brown)
            Spacer()
            
            Button(action: {
                showDocumentPicker = true
            }) {
                Text(Constants.addingFileText)
                    .font(.system(size: Constants.buttonTextSize, weight: .bold))
                    .padding(.vertical, Constants.buttonVPadding)
                    .frame(width: 250)
                    .background(Constants.beige)
                    .foregroundColor(Constants.brown)
                    .cornerRadius(Constants.buttonCornerRadius)
            }
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPicker { url in
                    selectedFileURL = url
                    showDocumentPicker = false
                }
            }
            
            Button(action: {
                showAddingExpenseScreen = true
            }) {
                Text(Constants.addingExpenseText)
                    .font(.system(size: Constants.buttonTextSize, weight: .bold))
                    .padding(.vertical, Constants.buttonVPadding)
                    .frame(width: 250)
                    .background(Constants.beige)
                    .foregroundColor(Constants.brown)
                    .cornerRadius(Constants.buttonCornerRadius)
            }
            .sheet(isPresented: $showAddingExpenseScreen) {
                AddingExpensesView()
            }
            
            Spacer()
            HStack {
                Spacer()
                Image(Constants.catImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.catWidth, height: Constants.catHeight)
                    .padding(.leading, Constants.catLPadding)
                ZStack {
                    Image(Constants.speachImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: Constants.speachHeight)
                        .padding(.trailing, 20)
                    Text(unloadRequestText)
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(Constants.brown)
                        .padding(.trailing, 20)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 8.5)
                        .onAppear {
                            startTypingAnimation()
                        }
                }
                .padding(.trailing, 20)
                .frame(width: 250, height: 300)
                Spacer()
            }
            .padding(.bottom, -30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Constants.lightBeige)
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
