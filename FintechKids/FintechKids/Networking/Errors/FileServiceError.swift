//
//  FileServiceError.swift
//  LLMServiceTest
//
//  Created by Тагир Файрушин on 28.03.2025.
//


enum FileServiceError: Error {
    case documentsDirectoryNotFound
    case fileCreationFailed(Error)
    case fileNotFound
    case fileReadingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .documentsDirectoryNotFound:
            return "Failed to access Documents directory"
        case .fileCreationFailed(let error):
            return "Error creating CSV file: \(error.localizedDescription)"
        case .fileNotFound:
            return "CSV file not found"
        case .fileReadingFailed(let error):
            return "Error reading CSV file: \(error.localizedDescription)"
        }
    }
}
