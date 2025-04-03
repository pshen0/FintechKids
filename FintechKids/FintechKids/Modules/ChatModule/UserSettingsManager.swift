//
//  UserSettingsManager.swift
//  FintechKids
//
//  Created by George Petryaev on 02.04.2025.
//

import Foundation
import UIKit
import Combine

class UserSettingsManager: ObservableObject {
    static let shared = UserSettingsManager()
    private let defaults = UserDefaults.standard
    
    @Published private(set) var currentAvatar: String
    @Published private(set) var currentAvatarImage: UIImage?
    
    private enum Keys {
        static let name = "userName"
        static let age = "userAge"
        static let hobbies = "userHobbies"
        static let avatar = "userAvatar"
        static let avatarImage = "userAvatarImage"
    }
    
    init() {
        self.currentAvatar = defaults.string(forKey: Keys.avatar) ?? "person.crop.circle.fill"
        if let imageData = defaults.data(forKey: Keys.avatarImage) {
            self.currentAvatarImage = UIImage(data: imageData)
        }
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
        get { currentAvatar }
        set {
            currentAvatar = newValue
            defaults.set(newValue, forKey: Keys.avatar)
        }
    }
    
    func saveUserData(name: String, age: String, hobbies: String, avatar: String, avatarImage: UIImage? = nil) {
        userName = name
        userAge = age
        userHobbies = hobbies
        userAvatar = avatar
        
        if let image = avatarImage, let imageData = image.jpegData(compressionQuality: 0.8) {
            defaults.set(imageData, forKey: Keys.avatarImage)
            currentAvatarImage = image
        } else {
            currentAvatarImage = nil
        }
    }
}
