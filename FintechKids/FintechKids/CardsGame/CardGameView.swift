//
//  CardGameView.swift
//  FintechKids
//
//  Created by Yandex Event on 26.03.2025.
//

import SwiftUI

struct CardGameView: View {
    @ObservedObject private var viewModel = CardGameViewModel(model: CardGameModel(name: "батон белого хлеба", image: Image("BreadImage"), cost: 150))
    @FocusState private var focusedField
    var body: some View {
        ZStack {
            Color.beige
                .ignoresSafeArea()
            VStack {
                attemptsLeft
                productImage
                questionText
                priceInputField
                checkButton
                feedBackText
            }
            .padding()
        }
    }
    
    private var attemptsLeft: some View {
        Text("Осталось попыток: \(viewModel.attempts)")
            .font(.title2)
            .multilineTextAlignment(.center)
            .padding()
            .padding(.top, 60)
    }
    
    private var productImage: some View {
        viewModel.model.image
            .resizable()
            .scaledToFit()
            .frame(height: 150)
            .padding()
    }
    
    private var questionText: some View {
        Text("Сколько стоит \(viewModel.model.name)?")
            .fixedSize(horizontal: false, vertical: true)
            .font(.title2)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    private var priceInputField: some View {
        TextField("Введи цену", text: $viewModel.userInput)
            .focused($focusedField)
            .keyboardType(.numberPad)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
//            .toolbar {
//                ToolbarItem(placement: .keyboard) {
//                    Button("Готово") {
//                        focusedField.toggle()
//                    }
//                     .frame(alignment: .leading)
//                }
//            }
    }
    
    private var checkButton: some View {
        Button("Проверить") {
            viewModel.checkPrice()
        }
        .padding()
        .background(Color.primaryOrange)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    
    private var feedBackText: some View {
        Text(viewModel.feedback)
            .font(.headline)
            .foregroundColor(.red)
            .padding()
    }
}

#Preview {
    CardGameView()
}
