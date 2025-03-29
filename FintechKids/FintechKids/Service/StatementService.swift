//
//  StatementService.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 28.03.2025.
//

import Foundation

class StatementService {
    private let llmService: LLMService
    
    init(llmService: LLMService) {
        self.llmService = llmService
    }
    
    func processStatement(text: String) async throws -> String {
        let prompt = Prompt.csv(text).getPromt
        let response = try await llmService.getMessage(prompt)
        
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
