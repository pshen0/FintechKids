//
//  SwiftUIView.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 01.04.2025.
//

import SwiftUI

struct TimerView: View {
    let progress: Double
    
    private enum Constants {
        static let cornerRadius: CGFloat = 12
        static let progressBarCornerRadius: CGFloat = 8
        static let progressBarHeight: CGFloat = 12
        static let containerHeight: CGFloat = 100
        static let horizontalPadding: CGFloat = 16
        static let bottomPadding: CGFloat = 10
        static let spacing: CGFloat = 12
        static let iconSize: CGFloat = 24
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            ZStack {
                backgroundRectangle
                
                VStack(spacing: Constants.spacing) {
                    HStack(spacing: Constants.spacing) {
                        timerIcon
                        timeLabel
                        Spacer()
                    }
                    .padding(.horizontal, Constants.horizontalPadding)
                    .padding(.top, Constants.horizontalPadding)
                    
                    progressBarContainer
                        .padding(.horizontal, Constants.horizontalPadding)
                        .padding(.bottom, Constants.horizontalPadding)
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, Constants.bottomPadding)
    }
    
    private var progressBarWidth: CGFloat {
        max(0, progress)
    }
    
    private var progressBarColor: Color {
        if progressBarWidth > 0.4 {
            return Color.green
        } else if progressBarWidth > 0.1 {
            return Color.orange
        } else {
            return Color.red
        }
    }
    
    private var remainingSeconds: Int {
        Int(progressBarWidth * 30)
    }
    
    private var backgroundRectangle: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color.gray.opacity(0.1))
            .frame(height: Constants.containerHeight)
    }
    
    private var progressBarBackground: some View {
        RoundedRectangle(cornerRadius: Constants.progressBarCornerRadius)
            .fill(Color.gray.opacity(0.1))
            .frame(height: Constants.progressBarHeight)
    }
    
    private var progressBarFill: some View {
        RoundedRectangle(cornerRadius: Constants.progressBarCornerRadius)
            .fill(progressBarColor)
    }
    
    private var timerIcon: some View {
        Image(systemName: "timer")
            .font(.title2)
            .foregroundStyle(.text.opacity(0.9))
    }
    
    private var timeLabel: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Осталось времени")
                .font(Font.custom(Fonts.deledda, size: 16))
                .foregroundStyle(.gray)
            Text("\(remainingSeconds) сек")
                .font(Font.custom(Fonts.deledda, size: 26))
                .foregroundStyle(.text.opacity(0.9))
        }
    }
    
    private var progressBarContainer: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                progressBarBackground
                progressBarFill
                    .frame(width: geometry.size.width * progressBarWidth, height: Constants.progressBarHeight)
            }
        }
        .frame(height: Constants.progressBarHeight)
    }
}
