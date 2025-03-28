//
//  BackSideGoalCardView.swift
//  FintechKids
//
//  Created by Михаил Прозорский on 27.03.2025.
//

import SwiftUI

struct BackSideGoalCardView: View {
    @Binding var goal: GoalModel
    @State var isEdit = false
    let formatter = DateFormatter()
    
    var body: some View {
        VStack {
            HStack {
                TextField(goal.name, text: $goal.name)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .disabled(!isEdit)
            }
            .overlay {
                Image(systemName: "pencil")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture {
                        isEdit.toggle()
                        // TODO: Здесь будет какая-нить popview для изменения данных
                    }
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Дата: \(goal.date.formattedDate())")
                Text("Накоплено: \(goal.current)")
                Text("Цель: \(goal.goalSum)")
                Text("Прогресс: \(goal.progress)")
            }
            
            Spacer()
        }
    }
}
