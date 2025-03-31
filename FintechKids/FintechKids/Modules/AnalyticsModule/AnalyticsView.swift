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
    enum Constants {
        static let screenNameText: String = " Аналитика трат "
        static let addingFileText: String = "Добавить выгрузку трат"
        static let addingExpenseText: String = "Добавить новую трату"
        
        static let catImageName: String = "cat"
        
        static let screenNameSize: CGFloat = 40
        static let buttonTextSize: CGFloat = 15
        static let buttonWidth: CGFloat = 150
        static let buttonHeight: CGFloat = 40
        static let buttonCornerRadius: CGFloat = 40
        static let catWidth: CGFloat = 70
        static let catHeight: CGFloat = 120
        static let catLPadding: CGFloat = 20
        static let catBPadding: CGFloat = 20
        
        static let plotWidth: CGFloat = 360
        static let plotHeight: CGFloat = 360
        static let plotStroke: CGFloat = 1
    }
    
    @State private var showAddingExpenseScreen = false
    @State private var showDocumentPicker = false
    @State private var selectedFileURL: URL?
    
    private var values: [Double] = [45.0, 50.0, 14.89, 35.9, 37.0]
    
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
        Text(Constants.screenNameText)
            .font(Font.custom(Fonts.deledda, size: Constants.screenNameSize))
            .padding()
            .foregroundColor(Color.text)
    }
    
    private var documentPickButton: some View {
        Button(action: {
            showDocumentPicker = true
        }) {
            Text(Constants.addingFileText)
                .font(Font.custom(Fonts.deledda, size: Constants.buttonTextSize))
                .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
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
                .font(Font.custom(Fonts.deledda, size: Constants.buttonTextSize))
                .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
                .background(Color.highlightedBackground)
                .foregroundColor(Color.text)
                .cornerRadius(Constants.buttonCornerRadius)
        }
        .sheet(isPresented: $showAddingExpenseScreen) {
            AddingExpensesView()
        }
    }
    
    private var catImage: some View {
        HStack {
            Image(Constants.catImageName)
                .resizable()
                .scaledToFit()
                .frame(width: Constants.catWidth, height: Constants.catHeight)
                .padding(.leading, Constants.catLPadding)
                .padding(.bottom, Constants.catBPadding)
            Spacer()
        }
    }
    
    private var plot: some View {
        ZStack {
            Plot(values)
                .fill(
                    Gradient(colors: [Color.text, Color.highlightedBackground, Color.red])
                )
                .frame(width: Constants.plotWidth, height: Constants.plotHeight)
            CoordinateAxes()
                .stroke(Color.text, lineWidth: Constants.plotStroke)
                .frame(width: Constants.plotWidth, height: Constants.plotHeight)
        }
    }
}

#Preview {
    AnalyticsView()
}
