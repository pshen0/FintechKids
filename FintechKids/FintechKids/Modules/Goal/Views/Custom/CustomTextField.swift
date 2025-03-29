//
//  CustomTextField.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 29.03.2025.
//

import SwiftUI

struct CustomtextField: View {
    @Binding var text: String
    @Binding var flag: Bool
    let width: CGFloat
    
    var body: some View {
        TextField("Goal", text: $text)
            .editingStyle(if: !flag)
            .frame(maxWidth: .infinity, alignment: .center)
            .disabled(!flag)
            .frame(width: 0.8 * width)
    }
}
