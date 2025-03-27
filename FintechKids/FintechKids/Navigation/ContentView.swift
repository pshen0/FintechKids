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
                GoalsView(index: $index)
            case 1:
                ChatScreen()
            case 2:
                CardGameView()
            default:
                Text("AAA")
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color("backgroundColor"))
    }
}

#Preview {
    ContentView(index: 0)
}
