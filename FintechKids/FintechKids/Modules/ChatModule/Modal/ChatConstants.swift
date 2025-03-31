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
}

struct Font {
    
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

struct ChatConstants {
    
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.width
    
    static let finikAvatar: (width: CGFloat, height: CGFloat) = (ChatConstants.width / 10, ChatConstants.width / 10)
}
