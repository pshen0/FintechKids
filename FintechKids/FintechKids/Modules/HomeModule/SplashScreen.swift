//
//  SplashScreenView.swift
//  FintechKids
//
//  Created by George Petryaev on 01.04.2025.
//

import SwiftUI
import SwiftData

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size: CGFloat = 0.8
    @State private var opacity = 0.5
    @State private var catSize: CGFloat = 0
    @State private var catOffset: CGFloat = 100
    @State private var circleScale: CGFloat = 1.0
    @State private var finalCatWidth: CGFloat = 135
    @State private var finalCatHeight: CGFloat = 231
    @State private var finalCatPosition: CGPoint = .zero
    @State private var currentCatImage = "cat1"
    @State private var isBlinking = false
    
    @EnvironmentObject private var storage: ScreenFactory
    
    var body: some View {
        if isActive {
            ContentView()
                .environmentObject(storage)
        } else {
            GeometryReader { geometry in
                ZStack {
                    Color.white.ignoresSafeArea()
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.highlightedBackground, location: 0.2),
                                    .init(color: Color.background, location: 1.5),
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .scaleEffect(circleScale)
                        .frame(width: 250, height: 250)
                    
                    Image(currentCatImage)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 150 + catSize,
                            height: 150 + catSize
                        )
                        .offset(
                            x: finalCatPosition.x * (1 - size),
                            y: catOffset + (finalCatPosition.y * (1 - size))
                        )
                        .onAppear {
                            let screenHeight = geometry.size.height
                            finalCatPosition = CGPoint(
                                x: 0,
                                y: (screenHeight / 2) - 200
                            )
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.size = 1.0
                    self.opacity = 1.0
                }
                
                withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                    self.catOffset = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    startTripleBlinkingAnimation()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.catSize = 50
                        self.circleScale = 10
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeIn(duration: 0.3)) {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
    
    private func startTripleBlinkingAnimation() {
        let blinkSequence = ["cat1", "cat2", "cat3", "cat4", "cat5", "cat6", "cat5", "cat4", "cat3", "cat2", "cat1"]
        let duration = 0.015
        let pauseBetweenBlinks = 0.5
        
        blinkOnce(sequence: blinkSequence, duration: duration) {
            DispatchQueue.main.asyncAfter(deadline: .now() + pauseBetweenBlinks) {
                blinkOnce(sequence: blinkSequence, duration: duration) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + pauseBetweenBlinks) {
                        blinkOnce(sequence: blinkSequence, duration: duration)
                    }
                }
            }
        }
    }
    
    private func blinkOnce(sequence: [String], duration: Double, completion: (() -> Void)? = nil) {
        var currentIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { timer in
            withAnimation(.linear(duration: duration)) {
                self.currentCatImage = sequence[currentIndex]
            }
            
            currentIndex += 1
            if currentIndex >= sequence.count {
                timer.invalidate()
                completion?()
            }
        }
    }
}

#Preview {
    SplashScreen()
}

