//
//  AnalyticsView.swift
//  FintechKids
//
//  Created by Анна Сазонова on 31.03.2025.
//

import SwiftUI

enum Fonts {
    static let deledda: String = "DeleddaOpen-Light"
}

struct AnalyticsView: View {
    
    @State private var showAddingExpenseScreen = false
    @State private var showDocumentPicker = false
    @State private var selectedFileURL: URL?
    @State private var progress: Double = 0.0
    
    private var values: [Double] = [50.0, 20.0, 50, 30, 40.0]
    
    var body: some View {
        ZStack {
            screenName
            Color.background.ignoresSafeArea()
            gradient
            VStack {
                screenName
                Spacer()
                plot
                Spacer()
                HStack {
                    Spacer()
                    documentPickButton
                    Spacer()
                    addingExpenseButton
                    Spacer()
                }
                catImage
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
                .frame(width: buttonWidth, height: buttonHeight)
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
                .frame(width: buttonWidth, height: buttonHeight)
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
        HStack {
            Image(catImageName)
                .resizable()
                .scaledToFit()
                .frame(width: catWidth, height: catHeight)
                .padding(.leading, catLPadding)
                .padding(.bottom, catBPadding)
            Spacer()
        }
    }
    
    private var plot: some View {
        ZStack {
            CoordinateAxes()
                .stroke(Color.text, lineWidth: 1)
                .frame(width: plotWidth, height: plotHeight)
            
            Plot(values)
                .fill(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: color1, location: progress),
                            .init(color: color2, location: 0.2 + progress),
                            .init(color: color3, location: 0.4 + progress),
                            .init(color: color4, location: 0.6 + progress),
                            .init(color: color5, location: 0.8 + progress),
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: plotWidth, height: plotHeight)
                .onAppear {
                    withAnimation(.easeInOut(duration: plotAnimationDuration ).repeatForever(autoreverses: true)) {
                        progress = 0.5
                    }
                }
        }
    }
    
    //MARK: - Constants

    private let screenNameText: String = " Аналитика трат "
    private let addingFileText: String = "Добавить выгрузку трат"
    private let addingExpenseText: String = "Добавить новую трату"
    
    private let catImageName: String = "cat"
    
    private let screenNameSize: CGFloat = 40
    private let buttonTextSize: CGFloat = 15
    private let buttonWidth: CGFloat = 150
    private let buttonHeight: CGFloat = 40
    private let buttonCornerRadius: CGFloat = 40
    private let catWidth: CGFloat = 70
    private let catHeight: CGFloat = 120
    private let catLPadding: CGFloat = 20
    private let catBPadding: CGFloat = 20
    private let shadowButtonRadius: CGFloat = 6
    private let plotAnimationDuration: Double = 10
    
    private let plotWidth: CGFloat = 360
    private let plotHeight: CGFloat = 360
    private let plotStroke: CGFloat = 1
    
    private let color1 =  Color.init(red: 209/255, green: 129/255, blue: 240/255)
    private let color2 =  Color.init(red: 115/255, green: 163/255, blue: 239/255)
    private let color3 =  Color.init(red: 182/255, green: 224/255, blue: 155/255)
    private let color4 =  Color.init(red: 255/255, green: 231/255, blue: 110/255)
    private let color5 =  Color.init(red: 242/255, green: 151/255, blue: 76/255)
}

#Preview {
    AnalyticsView()
}
