//
//  TapBar.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 26.03.2025.
//

import SwiftUI

struct TabBar: View {
    @Binding var index: Int
    let icons: [SystemImages] = [.aimsScreen, .chatScreen, .statisticScreen]
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width / 6) {
            ForEach(0..<icons.count, id: \.self) {current in
                Button(action: {
                    index = current
                }) {
                    Image.load(icons[current], isSelected: index == current)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .scaleEffect(index != current ? 1.0 : 1.1)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: index)
                }
                .tint(.black)
                .opacity(0.9)
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.83, height: 58)
        .background(Color.customBlue)
        .cornerRadius(100)
    }
}
