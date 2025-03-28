//
//  DataProvider.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 28.03.2025.
//

import Foundation

class DataProvider {
    
    static let shared = DataProvider()
    
    private init() {}
    
    private lazy var dateFormatter = DateFormatter()
    
    func obtainTransactions(text: String) -> [Transaction] {
        var transactions: [Transaction] = []
        
        do {
            let textFile = try FileService.shared.readCSV()
            let components = textFile.components(separatedBy: "\n")
            
            for index in 1..<components.count {
                let component = components[index].components(separatedBy: ",")
                dateFormatter.dateFormat = "dd.MM.yyyy"
                if let date = dateFormatter.date(from: component[2]), let amount = Double(component[1]) {
                    transactions.append(
                        Transaction(date: date, amount: amount, category: component[0])
                    )
                }
            }
        } catch {
            print("Не удалась прочитать данные")
        }
        return transactions
    }
    
    func loadTransactions(pdfURL: URL) async -> [Transaction] {
        do {
            let pdfText = try await PDFService.shared.extractText(from: pdfURL)
            let response = try await LLMService.shared.analyzeTransactions(pdfText)
            
        } catch {
            
        }
    }
}
