//
//  DismissButtonLabel.swift
//  FintechKids
//
//  Created by Данил Забинский on 29.03.2025.
//

import SwiftUI

struct DismissButtonLabel: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "chevron.left")
            Text("Назад")
        }
        .foregroundStyle(.text)
        .padding(Padding.default)
        .font(Font.custom(Fonts.deledda, size: FontSizes.default))
    }
}
