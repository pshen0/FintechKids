//
//  ContentView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 26.03.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var index = 1
    @EnvironmentObject var storage: Storage
    var body: some View {
        VStack {
            switch index {
            case 0:
                GoalsView()
            case 1:
                HomeView(viewModel: storage.cardGameViewModel)
            case 2:
                StartAnalyticsView()
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
