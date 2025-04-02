//
//  CustomDropDownList.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 01.04.2025.
//

import Foundation
import SwiftUI


struct CustomDropDownList: View {
    let values: [GoalImportantLevels]
    @State var current: GoalImportantLevels
    var flag: Bool
    
    @Namespace private var namespace
    
    var body: some View {
        switch flag {
        case true:
            List {
                ForEach (0..<values.count, id: \.self) { index in
                    Text("\(values[index].rawValue)")
                        .opacity(current == values[index] ? 0.5: 1)
                        .matchedGeometryEffect(id: values[index], in: namespace)
                        .onTapGesture {
                            current = values[index]
                        }
                }
            }
            .cornerRadius(20)
            .listStyle(.plain)
            .scrollIndicators(.hidden)
        case false:
            Text(current.rawValue)
                .matchedGeometryEffect(id: current, in: namespace)
        }
    }
}
