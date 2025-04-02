//
//  Cloud.swift
//  FintechKids
//
//  Created by Данил Забинский on 01.04.2025.
//

import SwiftUI

struct Cloud: View {
    var body: some View {
        Image(systemName: SystemImage.cloud.getSystemName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: Double.random(in: 40...120))
            .foregroundStyle(.white.opacity(Double.random(in: 0.5...1)))
            .padding(.horizontal, Double.random(in: 2...5) * 20.0)
    }
}
