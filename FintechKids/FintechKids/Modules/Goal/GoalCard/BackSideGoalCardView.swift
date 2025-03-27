//
//  BackSideGoalCardView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct BackSideGoalCardView: View {
    let width: CGFloat
    @Binding var goal: GoalModel
    let formatter = DateFormatter()
    
    var body: some View {
        VStack {
            HStack {
                Text(goal.name)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .overlay {
                Image(systemName: "pencil")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture {
                        print("Tap")
                        // Здесь будет какая-нить popview на 90% ширины экрана для изменения данных
                    }
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Сумма \(goal.current)")
                Text("Дата: \(goal.date.formattedDate())")
                Text("Сумма \(goal.current)")
            }
            
            Spacer()
        }
        .frame(width: width * 0.9, height: width * 0.9)
    }
}

#Preview {
    ContentView()
}
