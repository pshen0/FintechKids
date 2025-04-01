//
//  LLMService.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 26.03.2025.
//

import Foundation

class LLMService {
    
    static let shared = LLMService()
    private let urlSession = URLSession.shared
    
    private init() {}
    
    private func encodeRequest(prompt: String) throws -> Data {
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
        
        return try JSONEncoder().encode(requestBody)
    }
    
    private func sendRequest(body: Data) async throws -> Data {
        let url = URL(string: "https://openrouter.ai/api/v1/chat/completions")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(LLMKeyProvider.apiKey.rawValue)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidServerResponse }
        
        return data
    }
    
    private func decodeResponse(data: Data) throws -> String {
        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
        return apiResponse.choices.first?.message.content ?? ""
    }
    
    func getMessage(_ prompt: String) async throws -> String {
        do {
            let requestBody = try encodeRequest(prompt: prompt)
            let response = try await sendRequest(body: requestBody)
            return try decodeResponse(data: response)
        } catch let error as EncodingError {
            throw NetworkingError.encodingError(error)
        } catch let error as DecodingError {
            throw NetworkingError.decodingError(error)
        } catch {
            throw NetworkingError.invalidServerResponse
        }
    }
}


