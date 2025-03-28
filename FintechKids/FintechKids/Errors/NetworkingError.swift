//
//  NetworkingError.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 26.03.2025.
//

import Foundation

enum NetworkingError: Error {

    case invalidServerResponse
    case serverError
    case invalidResponseFormat
    case decodingError(DecodingError)
    
    var errorMessage: String {
        switch self {
        case .invalidServerResponse:
            return "Invalid server response"
        case .serverError:
            return "Server error with code"
        case .invalidResponseFormat:
            return "Invalid response format from API"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}
