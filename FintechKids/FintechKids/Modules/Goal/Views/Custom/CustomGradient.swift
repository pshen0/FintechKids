//
//  CustomGradient.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 03.04.2025.
//

import SwiftUI

struct CustomGradient: View {
    var body: some View {
        LinearGradient (
            gradient: Gradient(stops: [
                .init(color: Color.highlightedBackground, location: 0.2),
                .init(color: Color.background, location: 0.6),
            ]),
            startPoint: .top,
            endPoint: .bottom
        ).ignoresSafeArea()
    }
}
