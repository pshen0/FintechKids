//
//  TimerOnboardView.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 02.04.2025.
//

import SwiftUI

struct TimerOnboardView: View {
    @Binding var showInstructions: Bool
    let onReturnToGame: () -> Void
    @StateObject private var viewModel = OnboardsViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "timer")
                .imageScale(.large)
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            Text("Таймер, братан!")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.blue)
            
            Text("У тебя есть 30 секунд на выбор продуктов. Делай это быстро и правильно!")
                .font(.system(size: 18))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
                .lineSpacing(4)
            
            TimerView(progress: viewModel.progress)
                .padding(.horizontal)
        }
        .padding()
        .onReceive(viewModel.progressTimer) { _ in
            viewModel.handleProgressTimer()
        }
        .onAppear {
            viewModel.resetProgress()
        }
    }
}
