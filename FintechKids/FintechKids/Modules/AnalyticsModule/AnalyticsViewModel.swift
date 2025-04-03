//
//  AnalyticsViewModel.swift
//  FintechKids
//
//  Created by Анна Сазонова on 03.04.2025.
//

import Foundation


final class AnalyticsViewModel: ObservableObject {
    
    private var converter: TextToTransactionConverter = TextToTransactionConverter()
    private var fileStore: StatementFileStore = StatementFileStore()
    private var transactions: [Transaction]? = []
    @Published var catigorizedTransactions: [String:Double] = [:]
    
    init() {
        observedFile()
    }
    
    
    func loadFile(url: URL) {
        let statementController = StatementController(statementService: StatementService(llmService: LLMService.shared), statementFileStore: StatementFileStore())
        Task {
            try await statementController.processStatement(pdfURL:url)
        }
    }
    
    func observedFile() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(convertTransaction), name: Notification.Name("changeFile"), object: nil)
    }
    
    @objc func convertTransaction() {
        DispatchQueue.main.async {
            self.transactions = try? self.converter.obtainTransaction(text: self.fileStore.readCSV())
            if let receivedTransactions = self.transactions {
                for transaction in receivedTransactions {
                    self.catigorizedTransactions[transaction.category, default: 0] += abs(transaction.amount)
                }
            }
        }
    }
}
