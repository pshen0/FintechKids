//
//  StatementPDFToStringConverter.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 27.03.2025.
//

import Foundation
import PDFKit

enum StatementPDFToStringConverter {
    
    static func extractText(from pdfURL: URL) async throws -> String {
        guard let document = PDFDocument(url: pdfURL) else {
            throw PDFError.invalidDocument
        }
        
        var extractedText = ""
        
        for pageIndex in 0..<document.pageCount {
            if let page = document.page(at: pageIndex), let pageText = page.string {
                extractedText += pageText + "\n"
            }
        }
        
        return formatOperations(from: extractedText)
    }
    
    private static func formatOperations(from text: String) -> String {
        let pattern = #"(\d{2}\.\d{2}\.\d{4})\n(\d{2}:\d{2})\n(\d{2}\.\d{2}\.\d{4})\n(\d{2}:\d{2})\n([+-]?\d{1,3}(?:\s?\d{3})*\.\d{2} ₽) ([+-]?\d{1,3}(?:\s?\d{3})*\.\d{2} ₽) (.+)"#
   
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return text
        }
        
        let matches = regex.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))
        
        return matches.map { match -> String in
            let dateString = String(text[Range(match.range(at: 1), in: text)!])
            let time = String(text[Range(match.range(at: 2), in: text)!])
            let amount = String(text[Range(match.range(at: 5), in: text)!])
            let description = String(text[Range(match.range(at: 7), in: text)!])
            
            return "\(dateString) \(time);\(amount); \(description)"
        }.joined(separator: "\n")
    }
}
