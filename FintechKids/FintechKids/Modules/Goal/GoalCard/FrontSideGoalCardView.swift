//
//  FrontSideGoalCardView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct FrontSideGoalCardView: View {
    let width: CGFloat
    let image: String
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
        }
        .frame(width: width * 0.7, height: width * 0.7)
    }
}
