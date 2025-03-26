//
//  GoalView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 26.03.2025.
//

import SwiftUI

struct GoalView: View {
    @Binding var index: Int
    
    var body: some View {
        Text("Экран \(index)")
    }
}
