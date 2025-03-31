//
//  DataProvider.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 28.03.2025.
//

import Foundation

final class StatementController {
    
    private var statementService: StatementService
    private var statementFileStore: StatementFileStore
    
    init(statementService: StatementService, statementFileStore: StatementFileStore) {
        self.statementService = statementService
        self.statementFileStore = statementFileStore
    }
    
    public func processStatement(pdfURL: URL) async throws {
        do {
            let formattedTextPDF = try await StatementPDFToStringConverter.extractText(from: pdfURL)
            let csvFormattedText = try await statementService.processStatement(prompt: .csv(formattedTextPDF))
            try statementFileStore.writeCSV(textFile: csvFormattedText)
        } catch {
            print("Error processing statement: \(error)")
            throw error
        }
    }
}
