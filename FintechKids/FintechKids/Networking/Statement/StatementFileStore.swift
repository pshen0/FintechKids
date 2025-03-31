//
//  StatementFileStore.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 27.03.2025.
//

import Foundation

final class StatementFileStore {
    
    var cache: String?

    private var fileURL: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ParsedData.csv")
    }
    
    func writeCSV(textFile: String) throws {
        guard let fileURL else {
            throw FileServiceError.documentsDirectoryNotFound
        }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.removeItem(at: fileURL)
        }

        try textFile.write(to: fileURL, atomically: true, encoding: .utf8)
        NotificationCenter.default.post(name: NSNotification.Name("changeFile"), object: nil)
        cache = nil
    }
    
    func readCSV() throws -> String {
        if let cache { return cache }
        guard let fileURL = fileURL else {
            throw FileServiceError.documentsDirectoryNotFound
        }
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            throw FileServiceError.fileNotFound
        }
        
        do {
            let cache = try String(contentsOf: fileURL, encoding: .utf8)
            self.cache = cache
            return cache
        } catch {
            throw FileServiceError.fileReadingFailed(error)
        }
    }
    
    func addToCSV(textToAdd: String) throws {
        guard let fileURL else {
            throw FileServiceError.documentsDirectoryNotFound
        }
        
        let existingContent = try readCSV()
        
        let newContent = existingContent + "\n" + textToAdd
        try newContent.write(to: fileURL, atomically: true, encoding: .utf8)
        cache = nil
    }
}
