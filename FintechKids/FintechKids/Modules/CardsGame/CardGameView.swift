//
//  CardGameView.swift
//  FintechKids
//
//  Created by Margarita Usova on 26.03.2025.
//

import SwiftUI

struct CardGameView: View {
    @ObservedObject var viewModel: CardGameViewModel
    @FocusState private var focusedField
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.beige
                .ignoresSafeArea()
            VStack {
                backButton
                attemptsLeft
                productImage
                questionText
                priceInputField
                checkButton
                feedBackText
            }
            .padding()
            .animation(.easeInOut, value: viewModel.showNext)
        }
        .onTapGesture {
            endEditing()
        }
    }
    
    private var backButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.medium)
                    Text("Назад")
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    private var attemptsLeft: some View {
        Text("Осталось попыток: \(viewModel.attempts)")
            .font(.title2)
            .multilineTextAlignment(.center)
            .padding()
            .padding(.top, 60)
    }
    
    private var productImage: some View {
        Image(viewModel.model.imageName)
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
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .foregroundColor(.red)
            .padding()
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
