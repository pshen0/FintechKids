//
//  ContentView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 26.03.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var index = 0
    
    var body: some View {
        VStack {
            switch index {
            case 0:
                CardGameView()
            case 1:
                GoalView(index: $index)
            case 2:
                GoalView(index: $index)
            default:
                Text("AAA")
            }
            Spacer()
            
            TapBar(index: $index)
        }
        .padding(.bottom, 5)
        .background(Color.beige)
    }
}

#Preview {
    ContentView()
}
