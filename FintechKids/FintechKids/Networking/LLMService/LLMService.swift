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
            model: "google/gemini-2.0-flash-exp:free",
            messages: [
                MessageRequest(
                    role: "user",
                    content: [
                        MessageContent(type: "text", text: prompt)
                    ]
                )
            ]
        )
        
        let body = try JSONEncoder().encode(requestBody)
        
        /*sendDebugRequest(url: URL(string: "https://openrouter.ai/api/v1/chat/completions")!,
                         apiKey: LLMKeyProvider.apiKey.rawValue,
                         body: body)*/
        
        return body
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
    
    /*private func sendDebugRequest(url: URL, apiKey: String, body: Data?) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("✅ Status code: \(httpResponse.statusCode)")
            } else {
                print("⚠️ No HTTPURLResponse received")
            }
            
            if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                print("📦 Response body:\n\(responseBody)")
            } else {
                print("⚠️ No data received or failed to decode as UTF-8")
            }
        }
        
        task.resume()
    }*/
}


