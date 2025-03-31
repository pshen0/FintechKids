//
//  Storage.swift
//  FintechKids
//
//  Created by Margarita Usova on 27.03.2025.
//

import Foundation

class Storage {
    func loadFromBundle() -> [CardGameRound] {
        guard let url = Bundle.main.url(forResource: "CardGame", withExtension: "txt") else {
            print("Файл CardGame.txt не найден в Bundle!")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let rounds = try JSONDecoder().decode([CardGameRound].self, from: data)
            return rounds
        } catch {
            print("Ошибка при загрузке данных из Bundle: \(error)")
            return []
        }
    }
}
