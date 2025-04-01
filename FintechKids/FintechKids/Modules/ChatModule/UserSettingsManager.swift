//
//  UserSettingsManager.swift
//  FintechKids
//
//  Created by George Petryaev on 02.04.2025.
//

import Foundation

class UserSettingsManager {
    static let shared = UserSettingsManager()
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let name = "userName"
        static let age = "userAge"
        static let hobbies = "userHobbies"
        static let avatar = "userAvatar"
    }
    
    var userName: String {
        get { defaults.string(forKey: Keys.name) ?? "" }
        set { defaults.set(newValue, forKey: Keys.name) }
    }
    
    var userAge: String {
        get { defaults.string(forKey: Keys.age) ?? "" }
        set { defaults.set(newValue, forKey: Keys.age) }
    }
    
    var userHobbies: String {
        get { defaults.string(forKey: Keys.hobbies) ?? "" }
        set { defaults.set(newValue, forKey: Keys.hobbies) }
    }
    
    var userAvatar: String {
        get { defaults.string(forKey: Keys.avatar) ?? "person.crop.circle.fill" }
        set { defaults.set(newValue, forKey: Keys.avatar) }
    }
    
    func saveUserData(name: String, age: String, hobbies: String, avatar: String) {
        userName = name
        userAge = age
        userHobbies = hobbies
        userAvatar = avatar
    }
}
