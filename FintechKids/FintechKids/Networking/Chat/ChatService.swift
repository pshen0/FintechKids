//
//  ChatService.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 29.03.2025.
//

import Foundation

final class ChatService {
    static var replied = false
    
    func getFinickMessage(promt: Prompt) async throws -> String {
        let message = try await LLMService.shared.getMessage(promt.getPromt)
        guard message.count > 0 else {
            throw NetworkingError.invalidServerResponse
        }
        if !ChatService.replied {
            ChatService.replied.toggle()
            return message
        } else {
            var trimmedMessage = message.split(separator: " ")
            return trimmedMessage[1...].joined(separator: " ")
        }
    }
}
