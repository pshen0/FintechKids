//
//  BodyRequest.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 26.03.2025.
//

import Foundation

struct RequestBody: Codable {
    let model: String
    let messages: [MessageRequest]
}
