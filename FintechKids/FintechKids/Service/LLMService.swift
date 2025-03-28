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
    
    func analyzeTransactions(_ transactions: String) async throws -> [Transaction] {
        let url = URL(string: "https://openrouter.ai/api/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = RequestBody(
            model: "google/gemini-2.0-flash-thinking-exp:free",
            messages: [
                Message(
                    role: "user",
                    content: [
                        MessageContent(type: "text", text: Prompt.csv(transactions).getPromt)
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
                let transactionLines = apiResponse.choices.first?.message.content.split(separator: "\n")
                var transactions: [Transaction] = [Transaction]()
                if let transactionLines {
                    for index in 2..<transactionLines.count - 1 {
                        let transactionData = transactionLines[index].split(separator: ",")
              
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd.MM.yyyy"
                    
                        if let date = dateFormatter.date(from: String(transactionData[2])), let amount = Double(transactionData[1]) {
                            transactions.append(
                                Transaction(date: date, amount: amount, category: String(transactionData[2]))
                            )
                        } else {
                            print("Date conversion error: \(transactionData[2])")
                        }
                    }
                }
                if let text = apiResponse.choices.first?.message.content {
                    try FileService.shared.writeCSV(textFile: text)
                }
                
                return transactions
            } catch {
                throw NetworkingError.decodingError(error as! DecodingError)
            }
        } catch {
            throw NetworkingError.invalidServerResponse
        }
    }
}

