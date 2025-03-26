//
//  TapBar.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 26.03.2025.
//

import SwiftUI

struct TapBar: View {
    @Binding var index: Int
    let icons: [String] = ["gamecontroller", "rublesign.circle", "person"]
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width / 4) {
            ForEach(0..<icons.count, id: \.self) {current in
                Button(action: {
                    index = current
                }) {
                    Image(systemName: index != current ? icons[current] : (icons[current] + ".fill"))
                        .resizable()
                        .frame(width: current == 0 ? 30 : 25, height: 25)
                        .scaleEffect(index != current ? 1.0 : 1.2)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: index)
                }
                .tint(.black)
                .opacity(0.9)
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.95, height: 50)
        .background(Color(red: 240 / 255, green: 228 / 255, blue: 228 / 255, opacity: 0.5))
        .cornerRadius(20)
    }
}
