//
//  viewExtensionForLoadImage.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 31.03.2025.
//

import SwiftUI

extension View {
    func loadSavedImage(imageName: String) -> UIImage {
        let filepath = getDocumentsDirectory().appendingPathComponent(imageName)
        guard let data = try? Data(contentsOf: filepath),
              let image = UIImage(data: data) else {
            return UIImage(named: "templateGoal")!
        }
        return image
    }
    
    func getDocumentsDirectory() -> URL {
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("error with path")
            return URL(fileURLWithPath: "")
        }
        return path
    }
}
