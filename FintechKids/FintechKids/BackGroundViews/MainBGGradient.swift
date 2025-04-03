//
//  MainBGGradient.swift
//  FintechKids
//
//  Created by Данил Забинский on 02.04.2025.
//

import SwiftUI

struct MainBGGradient: View {
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


