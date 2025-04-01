//
//  DismissButtonLabel.swift
//  FintechKids
//
//  Created by Данил Забинский on 29.03.2025.
//

import SwiftUI

struct DismissButtonLabel: View {
    var body: some View {
        HStack(spacing: Padding.small) {
            Image(systemName: SystemImage.goBack.getSystemName)
                .fontWeight(.medium)
            Text("Назад")
                .modifier(CustomFont(size: FontSizes.default))
        }
    }
}
