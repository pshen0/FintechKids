//
//  CardView.swift
//  FintechKids
//
//  Created by Margarita Usova on 02.04.2025.
//
import SwiftUI

struct CardViewContent: View {
    var flipp = false
    var frontText: String
    var image: Image
    var answerText: String
    var backColor: Color = .red
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                CardView(color: Color.highlightedBackground, flipp: flipp) {
                    VStack(spacing: 16) {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: geometry.size.height * 0.5)
                            .padding(.top, 8)
                        
                        Text(frontText)
                            .font(.system(size: min(geometry.size.width * 0.05, 22)))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                    }
                }
                .opacity(flipp ? 0 : 1)
                .rotation3DEffect(.degrees(flipp ? -180 : 0), axis: (x: 0, y: 1, z: 0))
                
                CardView(color: backColor, flipp: flipp) {
                    VStack(spacing: 16) {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: geometry.size.height * 0.5)
                            .padding(.top, 8)
                        
                        Text(answerText)
                            .font(.system(size: min(geometry.size.width * 0.05, 22)))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                    }
                }
                .opacity(flipp ? 1 : 0)
                .rotation3DEffect(.degrees(flipp ? 0 : 180), axis: (x: 0, y: 1, z: 0))
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(1.2, contentMode: .fit)
        }
    }
}

struct CardView<Content: View>: View {
    var color: Color
    var flipp: Bool
    var content: () -> Content
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                .padding(16)
            content()
        }
    }
}

#Preview {
    CardViewContent(frontText: "Hello", image: Image(systemName: "star.fill"), answerText: "Bye")
}
