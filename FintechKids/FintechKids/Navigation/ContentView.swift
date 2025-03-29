//
//  ContentView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 26.03.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var screenFactory: ScreenFactory
    @State var index = 1
    var body: some View {
        VStack {
            switch index {
            case 0:
                GoalsView()
            case 1:
                HomeView(screen: .Analytics)
            case 2:
                AnalyticsView()
            default:
                Text("AAA")
            }
            Spacer()
            
            TabBar(index: $index)
        }
        .frame(maxWidth: .infinity)
        .background(Color.background)
    }
}

#Preview {
    ContentView(index: 0)
}
