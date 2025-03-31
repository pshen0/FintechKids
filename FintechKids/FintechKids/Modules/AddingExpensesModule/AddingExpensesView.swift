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
            Text(addingExpensesText)
                .font(Font.custom(Fonts.deledda, size: addingExpensesSize))
                .fontWeight(.bold)
                .padding(.bottom, bPadding)
                .padding(.top, tPadding)
                .foregroundColor(Color.text)
            List {
                AddingExpensesFieldCoast(text: addingCoastText)
                AddingExpensesFieldCategory(text: addingCategoryText)
                AddingExpensesFieldDate(text: addingDateText)
            }
            .listStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.highlightedBackground)
        
    }
    
    // MARK: - Constants
    
    private let addingExpensesText: String = "Добавление новой траты"
    private let addingCoastText: String = "Сумма траты:"
    private let addingCategoryText: String = "Категория:"
    private let addingDateText: String = "Дата:"
    private let addingExpensesSize: CGFloat = 25
    private let bPadding: CGFloat = 50
    private let tPadding: CGFloat = 30
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
                        .foregroundColor(selectedOption.isEmpty ? .secondary.opacity(opacity) : Color.text)
                    Spacer()
                }
                .background(Color.highlightedBackground)
                .cornerRadius(cornerRadius)
            }
            .simultaneousGesture(TapGesture().onEnded {
                isMenuOpen.toggle()
            })
            
            Rectangle()
                .fill(Color.clear)
                .frame(height: isMenuOpen ? rectangleHeight : 0)
                .animation(.easeInOut(duration: duration), value: isMenuOpen)
        }
        .onTapGesture {
            isMenuOpen = false
        }
        .listRowBackground(Color.highlightedBackground)
    }
    
    // MARK: - Constants
    
    private let opacity: CGFloat = 0.5
    private let cornerRadius: CGFloat = 10
    private let rectangleHeight: CGFloat = 150
    private let duration: Double = 0.3
}

struct AddingExpensesFieldDate: View {
    let text: String
    @State private var input: Date = Date()
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.secondary.opacity(opacity))
                .padding(.trailing, tPadding)
            DatePicker("", selection: $input, displayedComponents: [.date])
                .labelsHidden()
                .foregroundColor(.secondary.opacity(opacity))
                .foregroundStyle(Color.text)
                .tint(Color.text)
            Spacer()
        }
        .listRowBackground(Color.highlightedBackground)
    }
    
    // MARK: - Constants
    
    private let opacity: CGFloat = 0.5
    private let tPadding: CGFloat = 20
}

#Preview {
    AddingExpensesView()
}
