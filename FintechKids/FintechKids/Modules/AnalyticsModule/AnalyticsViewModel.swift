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
    @Published var transactions: [Transaction]? = []
    @Published var catigorizedTransactions: [String:Double] = [:]
    @Published var unloadRequest: String = ""
    @Published var loadingProcess: String = ""
    @Published var loadedResult: String = ""
    @Published var isLoading: LoadCases = .unloaded
    
    private let savedFileURLKey = "savedStatementFileURL"
    private let savedTransactionsKey = "savedCategorizedTransactions"
    private let savedRawTransactionsKey = "savedRawTransactions"
    
    init() {
        observedFile()
        loadSavedFileIfExists()
        loadSavedTransactions()
        loadSavedRawTransactions()
    }
    
    private func loadSavedTransactions() {
        if let savedData = UserDefaults.standard.dictionary(forKey: savedTransactionsKey) as? [String: Double] {
            self.catigorizedTransactions = savedData
        }
    }
    
    private func saveTransactions() {
        UserDefaults.standard.set(catigorizedTransactions, forKey: savedTransactionsKey)
    }
    
    private func loadSavedFileIfExists() {
        if let savedURLString = UserDefaults.standard.string(forKey: savedFileURLKey),
           let url = URL(string: savedURLString) {
            loadFile(url: url)
        }
    }
    
    private func saveFileURL(_ url: URL) {
        UserDefaults.standard.set(url.absoluteString, forKey: savedFileURLKey)
    }
    
    private func loadSavedRawTransactions() {
        if let savedData = UserDefaults.standard.data(forKey: savedRawTransactionsKey),
           let decodedTransactions = try? JSONDecoder().decode([Transaction].self, from: savedData) {
            self.transactions = decodedTransactions
        }
    }
    
    private func saveRawTransactions() {
        if let transactions = transactions,
           let encodedData = try? JSONEncoder().encode(transactions) {
            UserDefaults.standard.set(encodedData, forKey: savedRawTransactionsKey)
            
        }
    }
    
    func loadFile(url: URL) {
        saveFileURL(url)
        isLoading = .loading
        let statementController = StatementController(statementService: StatementService(llmService: LLMService.shared), statementFileStore: StatementFileStore())
        Task {
            try await statementController.processStatement(pdfURL:url)
            DispatchQueue.main.async {
                self.isLoading = .loaded
            }
        }
    }
    
    func observedFile() {
        NotificationCenter.default.addObserver(self, selector: #selector(convertTransaction), name: Notification.Name("changeFile"), object: nil)
    }
    
    @objc func convertTransaction() {
        DispatchQueue.main.async {
            self.transactions = try? self.converter.obtainTransaction(text: self.fileStore.readCSV())
            if let receivedTransactions = self.transactions {
                self.catigorizedTransactions.removeAll()
                for transaction in receivedTransactions {
                    self.catigorizedTransactions[transaction.category, default: 0] += abs(transaction.amount)
                }
                self.saveTransactions()
                self.saveRawTransactions()
            }
        }
    }
    
    // MARK: - Constants
    enum LoadCases {
        case unloaded
        case loading
        case loaded
    }
}
