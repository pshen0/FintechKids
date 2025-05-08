//
//  AnalyticsView.swift
//  FintechKids
//
//  Created by Анна Сазонова on 31.03.2025.
//

import SwiftUI

struct AnalyticsView: View {
    @ObservedObject var viewModel: AnalyticsViewModel
    @State private var showAddingExpenseScreen = false
    @State private var showDocumentPicker = false
    @State private var selectedFileURL: URL? = URL(string: "")
    @State private var progress: Double = 0.0
    @State private var charIndex = 0
    
    private var values: [String:Double] {
        return viewModel.catigorizedTransactions
    }
    
    init (viewModel: AnalyticsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            screenName
            Color.background.ignoresSafeArea()
            MainBGGradient()
            VStack {
                screenName
                Spacer()
                plot
                HStack {
                    Spacer()
                    documentPickButton
                    Spacer()
                }
                Spacer()
                
                HStack {
                    Spacer()
                    catImage
                    ZStack {
                        speechImage
                        speechText
                    }
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
    
    private var screenName: some View {
        HStack {
            Text(screenNameText)
                .font(Font.custom(Fonts.deledda, size: screenNameSize))
                .padding()
                .foregroundColor(Color.text)
            Spacer()
        }
    }
    
    private var documentPickButton: some View {
        Button(action: {
            showDocumentPicker = true
        }) {
            Text(addingFileText)
                .font(Font.custom(Fonts.deledda, size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color.text)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .background(Color.highlightedBackground)
                .cornerRadius(10)
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker { url in
                selectedFileURL = url
                Task {
                    await viewModel.loadFile(url: url)
                }
                showDocumentPicker = false
            }
        }
    }
    
    private var catImage: some View {
        Image(catImageName)
            .resizable()
            .scaledToFit()
            .frame(width: catWidth, height: catHeight)
            .padding(.leading, catLPadding)
            .padding(.bottom, catBPadding)
    }
    
    private var plot: some View {
        ZStack {
            CoordinateAxes()
                .stroke(Color.text, lineWidth: 1)
                .frame(width: plotWidth, height: plotHeight)
            
            PlotView(values: values, transactions: viewModel.transactions ?? [])
        }
    }
    
    private var speechImage: some View {
        Image(speechImageName)
            .resizable()
            .scaledToFit()
            .frame(width: speechWidth)
            .padding(.trailing, 20)
    }
    
    private var speechText: some View {
        var displayedText: String = ""
        var targetProperty: ReferenceWritableKeyPath<AnalyticsViewModel, String>
        
        switch viewModel.isLoading {
        case .loaded:
            targetProperty = \.loadedResult
        case .loading:
            targetProperty = \.loadingProcess
        case .unloaded:
            targetProperty = \.unloadRequest
        }
        
        displayedText = viewModel[keyPath: targetProperty]
        
        return Text(displayedText)
            .font(Font.custom(Fonts.deledda, size: 15))
            .foregroundColor(Color.text)
            .frame(width: speechWidth - speechPadding)
            .padding(.trailing, 20)
            .multilineTextAlignment(.center)
            .padding(.leading, 8.5)
            .onAppear {
                startTypingAnimation(viewModel.isLoading)
            }
            .onChange(of: viewModel.isLoading) {
                startTypingAnimation(viewModel.isLoading)
            }
    }

    
    private func startTypingAnimation(_ speechCase: AnalyticsViewModel.LoadCases) {
        var targetText: String
        var targetProperty: ReferenceWritableKeyPath<AnalyticsViewModel, String>

        switch speechCase {
        case .unloaded:
            targetText = unloadRequestText
            targetProperty = \.unloadRequest
        case .loading:
            targetText = loadingText
            targetProperty = \.loadingProcess
        case .loaded:
            targetText = loadedText
            targetProperty = \.loadedResult
        }

        viewModel[keyPath: targetProperty] = ""
        charIndex = 0

        Timer.scheduledTimer(withTimeInterval: typingAnimationDuration, repeats: true) { timer in
            if charIndex < targetText.count {
                let index = targetText.index(targetText.startIndex, offsetBy: charIndex)
                viewModel[keyPath: targetProperty].append(targetText[index])
                charIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    //MARK: - Constants
    private let screenNameText: String = " Аналитика трат "
    private let addingFileText: String = "Добавить выгрузку трат"
    private let addingExpenseText: String = "Добавить новую трату"
    private let unloadRequestText: String = "Чтобы начать отслеживать финансы, необходимо выгрузить траты"
    private let loadingText: String = "Идет загрузка..."
    private let loadedText: String = "Вот твоя аналитика трат"
    
    private let catImageName: String = "cat"
    private let speechImageName: String = "speech"
    
    private let screenNameSize: CGFloat = 40
    private let buttonTextSize: CGFloat = 15
    private let buttonWidth: CGFloat = 150
    private let buttonHeight: CGFloat = 40
    private let buttonCornerRadius: CGFloat = 40
    private let catWidth: CGFloat = 70
    private let catHeight: CGFloat = 120
    private let catLPadding: CGFloat = 20
    private let catBPadding: CGFloat = 20
    private let speechWidth: CGFloat = 280
    private let speechPadding: CGFloat = 10
    private let shadowButtonRadius: CGFloat = 6
    private let plotAnimationDuration: Double = 10
    private let typingAnimationDuration: Double = 0.03
    
    private let plotWidth: CGFloat = 360
    private let plotHeight: CGFloat = 360
    private let plotStroke: CGFloat = 1
    
    private let color1 =  Color.init(red: 209/255, green: 129/255, blue: 240/255)
    private let color2 =  Color.init(red: 115/255, green: 163/255, blue: 239/255)
    private let color3 =  Color.init(red: 182/255, green: 224/255, blue: 155/255)
    private let color4 =  Color.init(red: 255/255, green: 231/255, blue: 110/255)
    private let color5 =  Color.init(red: 242/255, green: 151/255, blue: 76/255)
}

