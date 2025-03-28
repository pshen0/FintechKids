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
    
    var body: some View {
        ZStack {
            switch index {
            case 0:
                GoalsView()
            case 1:
                HomeView()
            case 2:
                AnalyticsView()
            default:
                Text("AAA")
            }
            VStack {
                Spacer()
                
                TabBar(index: $index)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color("backgroundColor"))
    }
}

#Preview {
    ContentView(index: 0)
}
