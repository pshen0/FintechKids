//
//  TextToTransactionConverter.swift
//  FintechKids
//
//  Created by Тагир Файрушин on 28.03.2025.
//

import Foundation

final class TextToTransactionConverter {
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    func obtainTransaction(text: String) -> [Transaction] {
        let transactionLines = text.components(separatedBy: "\n")
        var transactions: [Transaction] = [Transaction]()
        
        
        for transaction in transactionLines {
            let transactionData = transaction.components(separatedBy: ",")
            
            if let date = dateFormatter.date(from: String(transactionData[2])), let amount = Double(transactionData[1]) {
                transactions.append(
                    Transaction(date: date, amount: amount, category: String(transactionData[2]))
                )
            } else {
                print("Date conversion error: \(transactionData[2])")
            }
        }
        
        return transactions
    }
}
