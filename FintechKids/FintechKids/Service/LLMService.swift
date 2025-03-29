//
//  LLMService.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 26.03.2025.
//

import Foundation

class LLMService {
    
    static let shared = LLMService()
    private let urlSession: URLSession = URLSession.shared
    private let apiKey = "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"
    
    private init() {}
    
    func getMessage(_ prompt: String) async throws -> String {
        let url = URL(string: "https://openrouter.ai/api/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = RequestBody(
            model: "google/gemini-2.0-flash-thinking-exp:free",
            messages: [
                MessageRequest(
                    role: "user",
                    content: [
                        MessageContent(type: "text", text: prompt)
                    ]
                )
            ]
        )
        
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkingError.invalidServerResponse
            }
            
            let decoder = JSONDecoder()
            
            do {
                let apiResponse = try decoder.decode(APIResponse.self, from: data)
                return apiResponse.choices.first?.message.content ?? ""
                            
            } catch {
                throw NetworkingError.decodingError(error as! DecodingError)
            }
        } catch {
            throw NetworkingError.invalidServerResponse
        }
    }
}


