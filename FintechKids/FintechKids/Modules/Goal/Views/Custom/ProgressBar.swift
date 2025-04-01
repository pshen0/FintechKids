//
//  ProgressBar.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 28.03.2025.
//

import SwiftUI

struct ThickLinearProgressViewStyle: ProgressViewStyle {
    var height: CGFloat = 100
    var progressColor: Color = Color("customBrown")
    var backgroundColor: Color = Color.background
    var width: CGFloat = 20

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            ZStack(alignment: .trailing) {
                Rectangle()
                    .frame(width: height, height: width)
                    .foregroundColor(backgroundColor)
                
                Rectangle()
                    .frame(width: min(CGFloat(configuration.fractionCompleted ?? 0) * height, height), height: width)
                    .foregroundColor(progressColor)
                    .animation(.easeInOut, value: configuration.fractionCompleted)
                    .cornerRadius(width / 2)
            }
            .cornerRadius(width / 2)
            .rotationEffect(.degrees(90), anchor: .center)
            .frame(width: width)
        }
    }
}
