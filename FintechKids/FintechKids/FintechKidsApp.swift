//
//  FintechKidsApp.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 26.03.2025.
//

import SwiftUI
import SwiftData

@main
struct FintechKidsApp: App {
    @StateObject private var screenFactory = ScreenFactory()
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(screenFactory)
        }
    }
}
