//
//  Message.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 26.03.2025.
//

import Foundation

struct MessageRequest: Codable {
    let role: String
    let content: [MessageContent]
}
