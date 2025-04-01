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
    
    @Namespace private var namespace
    
    var body: some View {
        switch flag {
        case false:
            Text(text)
                .matchedGeometryEffect(id: "text", in: namespace)
        case true:
            TextField("Goal", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity, alignment: .center)
                .disabled(!flag)
                .frame(width: 0.8 * width)
                .matchedGeometryEffect(id: "text", in: namespace)
        }
    }
}
