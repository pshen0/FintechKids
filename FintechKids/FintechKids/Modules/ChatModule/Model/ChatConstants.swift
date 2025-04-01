//
//  ChatConstants.swift
//  FintechKids
//
//  Created by Данил Забинский on 30.03.2025.
//

import UIKit

struct Padding {
    
    static let small: CGFloat = 5
    static let `default`: CGFloat = 10
    static let medium: CGFloat = 15
}

struct FontSizes {
    
    static let time: CGFloat = 12
    static let `default`: CGFloat = 16
    static let big: CGFloat = 20
}

enum SystemImage {
    
    case sendMessage
    case goBack
    case cloud
    
    var getSystemName: String {
        switch self {
        case .sendMessage:
            return "paperplane.fill"
        case .goBack:
            return "chevron.left"
        case .cloud:
            return "cloud.fill"
        }
    }
}

struct ScreenSize {
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.width
}

struct ChatConstants {
    
    static let finikAvatar: CGSize = CGSize(width: ScreenSize.screenWidth / 10, height: ScreenSize.screenWidth / 10)
}
