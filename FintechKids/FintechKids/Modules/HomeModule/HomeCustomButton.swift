//
//  HomeCustomButton.swift
//  FintechKids
//
//  Created by Анна Сазонова on 27.03.2025.
//

import SwiftUI

struct CustomButton<Content: View>: View {
    let title: String
    @Binding var isPresented: Bool
    let destination: Content
    
    var body: some View {
        Button(action: {
            isPresented = true
        }) {
            Text(title)
                .font(.system(size: HomeView.Constants.buttonTextSize, weight: .bold))
                .frame(width: 250)
                .padding(.vertical, HomeView.Constants.buttonVPadding)
                .background(HomeView.Constants.beige)
                .foregroundColor(HomeView.Constants.brown)
                .cornerRadius(HomeView.Constants.buttonCornerRadius)
        }
        .fullScreenCover(isPresented: $isPresented) {
            destination
                .interactiveDismissDisabled(true)
        }
    }
}
