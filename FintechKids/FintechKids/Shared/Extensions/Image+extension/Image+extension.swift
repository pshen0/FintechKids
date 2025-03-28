//
//  Image+extension.swift
//  FintechKids
//
//  Created by Данил Забинский on 26.03.2025.
//

import SwiftUI

enum SystemImages: String {
    
    case aimsScreen = "aims_screen_image"
    case chatScreen = "chat_screen_image"
    case statisticScreen = "statistic_screen_image"

    
    func getImageName(_ isSelected: Bool) -> String {
        isSelected ? self.rawValue + "_selected" : self.rawValue
    }
}

extension Image {
    static func load(_ systemImage: SystemImages, isSelected: Bool) -> Image {
        let imageName = systemImage.getImageName(isSelected)
        return Image(imageName)
    }
}
