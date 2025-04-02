//
//  CustomImageEditButton.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 29.03.2025.
//

import SwiftUI

struct CustomImageEditButton: View {
    @Binding var flag: Bool
    var update: () -> Void
    
    var body: some View {
        Image(systemName: !flag ? "pencil": "checkmark")
            .frame(maxWidth: .infinity, alignment: .trailing)
            .onTapGesture {
                withAnimation {
                    if flag {
                        update()
                    }
                    flag.toggle()
                }
            }
    }
}
