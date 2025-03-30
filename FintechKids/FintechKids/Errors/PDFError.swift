//
//  PDFError.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 27.03.2025.
//

import Foundation

enum PDFError: Error {
    case invalidDocument
    
    var errorMessage: String {
        switch self {
        case .invalidDocument: return "Invalid pdf document"
        }
    }
}
