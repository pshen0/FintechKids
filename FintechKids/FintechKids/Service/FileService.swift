//
//  FileService.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 27.03.2025.
//

import Foundation

class FileService {
    static let shared = FileService()
    
    private init() {}
    
    private var fileManager = FileManager.default
    
    private var fileURL: URL? {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ParsedData.csv")
    }
    
    private func processText(_ text: String) -> String {
        text.components(separatedBy: .newlines)
            .dropFirst()
            .dropLast()
            .joined(separator: "\n")
    }
    
    func writeCSV(textFile: String) throws {
        guard let fileURL else {
            throw FileServiceError.documentsDirectoryNotFound
        }
        
        if fileManager.fileExists(atPath: fileURL.path) {
            try fileManager.removeItem(at: fileURL)
        }
        
        let processText = processText(textFile)
        try processText.write(to: fileURL, atomically: true, encoding: .utf8)
        print("Cохранись пожалуйста, я устал")
    }
    
    func readCSV() throws -> String {
        guard let fileURL = fileURL else {
            throw FileServiceError.documentsDirectoryNotFound
        }
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            throw FileServiceError.fileNotFound
        }
        
        do {
            return try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            throw FileServiceError.fileReadingFailed(error)
        }
    }
}
