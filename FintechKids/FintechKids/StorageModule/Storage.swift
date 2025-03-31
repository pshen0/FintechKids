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
                name: "батон белого хлеба",
                imageName: "BreadImage",
                cost: 80
            ),
            CardGameRound(
                name: "мороженое",
                imageName: "IceCreamImage",
                cost: 100
            ),
            CardGameRound(
                name: "ветка бананов",
                imageName: "BreadImage",
                cost: 180
            ),
            CardGameRound(
                name: "бутылка молока",
                imageName: "BreadImage",
                cost: 90
            )
        ]
    )
    
}
