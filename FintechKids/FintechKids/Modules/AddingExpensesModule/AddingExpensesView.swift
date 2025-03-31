//
//  AddingExpensesView.swift
//  FintechKids
//
//  Created by Анна Сазонова on 26.03.2025.
//

import SwiftUI

struct AddingExpensesView: View {
    enum FocusableField {
        case cost, category, date
    }
    
    @State private var isMenuOpen: Bool = false
    @FocusState private var focusedField: FocusableField?
    
    var body: some View {
        VStack {
            Text("Добавление новой траты")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 50)
                .padding(.top, 30)
                .foregroundColor(Color.text)
            List {
                AddingExpensesFieldCoast(text: "Сумма траты:")
                AddingExpensesFieldCategory(text: "Категория:")
                AddingExpensesFieldDate(text: "Дата:")
            }
            .listStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.highlightedBackground)
        
    }
}

struct AddingExpensesFieldCoast: View {
    let text: String
    @State private var input: String = ""
    
    var body: some View {
        TextField(text, text: $input)
            .foregroundStyle(Color.text)
            .listRowBackground(Color.highlightedBackground)
            .keyboardType(.numberPad)
            .tint(Color.text)
    }
}

struct AddingExpensesFieldCategory: View {
    let text: String
    @State private var selectedOption: String = ""
    @State var isMenuOpen: Bool = false
    let options = ["Категория 1", "Категория 2", "Категория 3"]
    
    var body: some View {
        VStack {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(option) {
                        selectedOption = option
                        isMenuOpen = false
                    }
                }
            } label: {
                HStack {
                    Text(selectedOption.isEmpty ? text : selectedOption)
                        .foregroundColor(selectedOption.isEmpty ? .secondary.opacity(0.5) : Color.text)
                    Spacer()
                }
                .background(Color.highlightedBackground)
                .cornerRadius(10)
            }
            .simultaneousGesture(TapGesture().onEnded {
                isMenuOpen.toggle()
            })
            
            Rectangle()
                .fill(Color.clear)
                .frame(height: isMenuOpen ? 150 : 0)
                .animation(.easeInOut(duration: 0.3), value: isMenuOpen)
        }
        .onTapGesture {
            isMenuOpen = false
        }
        .listRowBackground(Color.highlightedBackground)
    }
}

struct AddingExpensesFieldDate: View {
    let text: String
    @State private var input: Date = Date()
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.secondary.opacity(0.5))
                .padding(.trailing, 20)
            DatePicker("", selection: $input, displayedComponents: [.date])
                .labelsHidden()
                .foregroundColor(.secondary.opacity(0.5))
                .foregroundStyle(Color.text)
                .tint(Color.text)
            Spacer()
        }
        .listRowBackground(Color.highlightedBackground)
    }
}

#Preview {
    AddingExpensesView()
}
