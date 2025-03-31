//
//  Storage.swift
//  FintechKids
//
//  Created by Margarita Usova on 27.03.2025.
//

import Foundation
import SwiftUI

final class Storage: ObservableObject {
    @Published var cardGameViewModel = CardGameViewModel(
        rounds: [
            CardGameRound(
                name: "1 кг яблок",
                imageName: "AppleImage",
                cost: 70
            ),
            CardGameRound(
                name: "1 литр молока",
                imageName: "MilkImage",
                cost: 110
            ),
            CardGameRound(
                name: "1 авокадо",
                imageName: "AvocadoImage",
                cost: 130
            ),
            CardGameRound(
                name: "1 кокос",
                imageName: "CoconutImage",
                cost: 180
            )
        ]
    )
    
}
