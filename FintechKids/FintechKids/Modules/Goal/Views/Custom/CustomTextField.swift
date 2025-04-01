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
    let width: CGFloat?
    
    @Namespace private var namespace
    
    var body: some View {
        switch flag {
        case false:
            Text(text)
                .matchedGeometryEffect(id: "text", in: namespace)
        case true:
            TextField("Goal", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: width == nil ? nil: width! * 0.8)
                .matchedGeometryEffect(id: "text", in: namespace)
        }
    }
}
