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
    @State var isHiddenBar: Bool = false
    var body: some View {
        ZStack {
            switch index {
            case 0:
                GoalsView(isHiddenBar: $isHiddenBar)
            case 1:
                HomeView(screen: .analytics, screenFactory: screenFactory)
            case 2:
                AnalyticsView(viewModel: AnalyticsViewModel())
            default:
                Text("AAA")
            }
            VStack {
                Spacer()
                
                if !isHiddenBar {
                    TabBar(index: $index)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.background)
    }
}
