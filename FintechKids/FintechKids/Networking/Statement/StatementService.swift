//
//  StatementService.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 28.03.2025.
//

import Foundation

final class StatementService {
    private let llmService: LLMService
    
    init(llmService: LLMService) {
        self.llmService = llmService
    }
    
    func processStatement(prompt: Prompt) async throws -> String {
        let response = try await llmService.getMessage(prompt.getPromt)
        
        guard !response.isEmpty else {
            throw NetworkingError.invalidResponseFormat
        }
        
        let components = response.components(separatedBy: "\n")
        guard components.count > 2 else {
            throw NetworkingError.invalidResponseFormat
        }
        
        return Array(components.dropFirst(2).dropLast()).joined(separator: "\n")
    }
    
}
