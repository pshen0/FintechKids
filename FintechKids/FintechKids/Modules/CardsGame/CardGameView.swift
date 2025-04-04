//
//  CardGameView.swift
//  FintechKids
//
//  Created by Margarita Usova on 26.03.2025.
//

import SwiftUI

struct CardGameView: View {
    @ObservedObject var viewModel: CardGameViewModel
    @FocusState private var isInputFieldFocused: Bool
    @Environment(\.dismiss) var dismiss
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                
                if viewModel.showGameOver {
                    gameOverView
                } else {
                    if viewModel.showSuccessAnimation {
                        successOverlay
                    }
                    
                    if viewModel.showErrorBackground {
                        errorOverlay
                    }
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("Раунд \(viewModel.currentRound + 1)/3")
                                .font(Font.custom(Fonts.deledda, size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(Color.text)
                            
                            Spacer()
                            
                            Text("Очки: \(viewModel.score)")
                                .font(Font.custom(Fonts.deledda, size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(Color.text)
                        }
                        .padding(.horizontal)
                        
                        attemptsLeft
                            .padding(.horizontal)
                        
                        productCard
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1.2, contentMode: .fit)
                            .padding(.horizontal)
                            .transition(.asymmetric(
                                insertion: .move(edge: .top).combined(with: .opacity).combined(with: .scale(scale: 0.8)),
                                removal: .move(edge: .bottom).combined(with: .opacity).combined(with: .scale(scale: 0.8))
                            ))
                        
                        feedbackText
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        priceInputField
                            .padding(.horizontal)
                            .padding(.bottom, keyboardHeight > 0 ? 5 : 16)
                    }
                }
            }
            .onTapGesture { endEditing() }
            .toolbar { navigationBar }
            .onAppear {
                setupKeyboardObservers()
            }
            .onDisappear {
                removeKeyboardObservers()
            }
        }
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            let height = value?.height ?? 0
            withAnimation(.easeOut(duration: 0.2)) {
                keyboardHeight = height
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            withAnimation(.easeOut(duration: 0.2)) {
                keyboardHeight = 0
            }
        }
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color.highlightedBackground, location: 0.2),
                .init(color: Color.background, location: 0.6)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
    
    private var navigationBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { dismiss() }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.medium)
                    Text("Назад")
                }
            }
            .font(Font.custom(Fonts.deledda, size: 20))
            .fontWeight(.bold)
            .foregroundColor(Color.text)
        }
    }
    
    private var attemptsLeft: some View {
        Text("Осталось попыток: \(viewModel.attempts)")
            .font(Font.custom(Fonts.deledda, size: 24))
            .fontWeight(.bold)
            .foregroundColor(Color.text)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }
    
    private var errorOverlay: some View {
        Rectangle()
            .fill(Color.red.opacity(0.2))
            .ignoresSafeArea()
            .opacity(viewModel.showErrorBackground ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: viewModel.showErrorBackground)
    }
    
    private var successOverlay: some View {
        Rectangle()
            .fill(Color.green.opacity(0.3))
            .overlay(
                Circle()
                    .fill(Color.green.opacity(0.2))
                    .frame(width: 200, height: 200)
                    .blur(radius: 50)
                    .scaleEffect(viewModel.showSuccessAnimation ? 2 : 0.1)
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.5), value: viewModel.showSuccessAnimation)
    }
    
    private var productCard: some View {
        ZStack {
            if !viewModel.flipp {
                CardViewContent(
                    flipp: viewModel.flipp,
                    frontText: "Сколько стоит \(viewModel.model.name)?",
                    image: Image(viewModel.model.imageName),
                    answerText: "Правильный ответ: \(viewModel.model.cost) ₽",
                    backColor: viewModel.wrongAnswer ? .red : .green
                )
                .id(viewModel.model.name)
            } else {
                CardViewContent(
                    flipp: viewModel.flipp,
                    frontText: "Сколько стоит \(viewModel.model.name)?",
                    image: Image(viewModel.model.imageName),
                    answerText: "Правильный ответ: \(viewModel.model.cost) ₽",
                    backColor: viewModel.wrongAnswer ? .red : .green
                )
                .id(viewModel.model.name)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
        .rotation3DEffect(
            .degrees(viewModel.flipp ? 180 : 0),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.5
        )
        .animation(.spring(response: 0.6, dampingFraction: 0.7), value: viewModel.flipp)
        .transition(.asymmetric(
            insertion: .asymmetric(
                insertion: .move(edge: .top).combined(with: .opacity).combined(with: .scale(scale: 0.8)),
                removal: .move(edge: .bottom).combined(with: .opacity).combined(with: .scale(scale: 0.8))
            ),
            removal: .asymmetric(
                insertion: .move(edge: .bottom).combined(with: .opacity).combined(with: .scale(scale: 0.8)),
                removal: .move(edge: .top).combined(with: .opacity).combined(with: .scale(scale: 0.8))
            )
        ))
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: viewModel.model.name)
    }

    private var priceInputField: some View {
        VStack(spacing: 8) {
            TextField("Введи цену", text: $viewModel.userInput)
                .font(Font.custom(Fonts.deledda, size: 18))
                .padding()
                .background(Color(UIColor.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black.opacity(0.1), radius: 5)
                .focused($isInputFieldFocused)
                .keyboardType(.numberPad)
            
            checkButton
        }
    }
    
    private var checkButton: some View {
        
        GradientButton(title: "Проверить", fontSize: 18, width: UIScreen.main.bounds.width * 0.95, height: nil) {
            viewModel.checkPrice()
        }
    }
    
    private var feedbackText: some View {
        Text(viewModel.feedback)
            .font(Font.custom(Fonts.deledda, size: 18))
            .fontWeight(.bold)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity)
    }
    
    private func handleAttemptsChange() {
        if viewModel.attempts == 0 {
            withAnimation(.easeInOut(duration: 0.3)) {
                viewModel.flipp = true
            }
        }
    }
    
    private func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private var gameOverView: some View {
        VStack(spacing: 24) {
            Text("Игра окончена!")
                .font(Font.custom(Fonts.deledda, size: 32))
                .fontWeight(.bold)
                .foregroundColor(Color.text)
            
            Text("Ваш результат: \(viewModel.score) очков")
                .font(Font.custom(Fonts.deledda, size: 24))
                .fontWeight(.bold)
                .foregroundColor(Color.text)
            
            Button(action: {
                viewModel.setupGame()
            }) {
                Text("Играть снова")
                    .font(Font.custom(Fonts.deledda, size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color.text)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.highlightedBackground)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.background.opacity(0.9))
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
        .transition(.scale.combined(with: .opacity))
    }
}

struct ShakeEffect: GeometryEffect {
    var shake: Bool
    
    var animatableData: CGFloat {
        get { shake ? 1 : 0 }
        set { shake = newValue > 0 }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let amount = shake ? 5.0 : 0.0
        let angle = sin(animatableData * .pi * 4) * amount * .pi / 180
        
        return ProjectionTransform(CGAffineTransform(rotationAngle: angle))
    }
}
