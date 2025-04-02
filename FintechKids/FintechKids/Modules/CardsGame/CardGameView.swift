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
    @State private var keyboardOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient (
                    gradient: Gradient(stops: [
                        .init(color: Color.highlightedBackground, location: 0.2),
                        .init(color: Color.background, location: 0.6),
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()
                
                VStack {
                    attemptsLeft
                        .padding(.top, 30)
                        .padding(.bottom, 5)
                    productImage
                        .padding(.top, 10)
                    questionText
                    priceInputField
                    feedBackText
                    Spacer()
                }
                .padding(.bottom, keyboardOffset)
                .animation(.easeInOut, value: keyboardOffset)
            }
            .onTapGesture {
                endEditing()
            }
            .keyboardAwarePadding($keyboardOffset)
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .fontWeight(.medium)
                            Text("Назад")
                        }
                    }
                    .font(Font.custom(Fonts.deledda, size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.text)
                }
            }
        }
    }
    
    private var attemptsLeft: some View {
        Text("Осталось попыток: \(viewModel.attempts)")
            .font(Font.custom(Fonts.deledda, size: 30))
            .fontWeight(.bold)
            .foregroundColor(Color.text)
            .multilineTextAlignment(.center)
            .padding(.top, 60)
    }
    
    private var productImage: some View {
        Image(viewModel.model.imageName)
            .resizable()
            .scaledToFit()
            .frame(height: 150)
            .scaleEffect(viewModel.showNext ? 0.1 : 1)
            .opacity(viewModel.showNext ? 0 : 1)
            .animation(.easeInOut(duration: 0.5), value: viewModel.showNext)
            .offset(x: viewModel.wrongAnswer ? -5 : 5)
            .animation(viewModel.wrongAnswer ? Animation.easeInOut(duration: 0.1).repeatCount(5) : .default, value: viewModel.wrongAnswer)
        
            .onChange(of: viewModel.showNext) { newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        viewModel.showNext = false
                    }
                }
            }
            .onChange(of: viewModel.wrongAnswer) { newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        viewModel.wrongAnswer = false
                    }
                }
            }
    }
    
    private var questionText: some View {
        Text("Сколько стоит \(viewModel.model.name)?")
            .font(Font.custom(Fonts.deledda, size: 20))
            .fontWeight(.medium)
            .foregroundColor(Color.text)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
    }
    
    private var priceInputField: some View {
        HStack {
            TextField("Введи цену", text: $viewModel.userInput)
                .font(Font.custom(Fonts.deledda, size: 15))
                .fontWeight(.medium)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color(UIColor.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black.opacity(0.1), radius: 5)
                .focused($focusedField)
                .keyboardType(.numberPad)
                .padding()
            checkButton
        }
        .padding()
    }
    
    private var checkButton: some View {
        Button("Проверить") {
            viewModel.checkPrice()
        }
        .padding()
        .font(Font.custom(Fonts.deledda, size: 20))
        .fontWeight(.bold)
        .background(Color.highlightedBackground)
        .foregroundColor(Color.text)
        .cornerRadius(10)
    }
    
    private var feedBackText: some View {
        Text(viewModel.feedback)
            .font(Font.custom(Fonts.deledda, size: 20))
            .fontWeight(.bold)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .foregroundColor(.red)
            .padding()
    }
    
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func keyboardAwarePadding(_ keyboardOffset: Binding<CGFloat>) -> some View {
        self
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    keyboardOffset.wrappedValue = keyboardFrame.height / 2
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                keyboardOffset.wrappedValue = 0
            }
    }
}
