//
//  AddingExpensesView.swift
//  FintechKids
//
//  Created by Анна Сазонова on 26.03.2025.
//

import SwiftUI

struct AddingExpensesView: View {
    
    enum Constants {
        static let brown: Color = Color(red: 89/255, green: 51/255, blue: 22/255)
        static let lightBeige: Color = Color(red: 255/255, green: 246/255, blue: 235/255)
        static let beige: Color = Color(red: 249/255, green: 220/255, blue: 184/255)
    }
    
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
                .foregroundColor(Constants.brown)
            List {
                AddingExpensesFieldCoast(text: "Сумма траты:")
                AddingExpensesFieldCategory(text: "Категория:")
                AddingExpensesFieldDate(text: "Дата:")
            }
            .listStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Constants.beige)
        
    }
}

struct AddingExpensesFieldCoast: View {
    enum Constants {
        static let brown: Color = Color(red: 89/255, green: 51/255, blue: 22/255)
        static let lightBeige: Color = Color(red: 255/255, green: 246/255, blue: 235/255)
        static let beige: Color = Color(red: 249/255, green: 220/255, blue: 184/255)
    }
    
    let text: String
    @State private var input: String = ""
    
    var body: some View {
        TextField(text, text: $input)
            .foregroundStyle(text.isEmpty ? Constants.brown : Constants.brown)
            .listRowBackground(Constants.beige)
            .keyboardType(.numberPad)
            .tint(Constants.brown)
    }
}

struct AddingExpensesFieldCategory: View {
    enum Constants {
        static let brown: Color = Color(red: 89/255, green: 51/255, blue: 22/255)
        static let lightBeige: Color = Color(red: 255/255, green: 246/255, blue: 235/255)
        static let beige: Color = Color(red: 249/255, green: 220/255, blue: 184/255)
    }
    
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
                        .foregroundColor(selectedOption.isEmpty ? .secondary.opacity(0.5) : Constants.brown)
                    Spacer()
                }
                .background(Constants.beige)
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
        .listRowBackground(Constants.beige)
    }
}

struct AddingExpensesFieldDate: View {
    enum Constants {
        static let brown: Color = Color(red: 89/255, green: 51/255, blue: 22/255)
        static let lightBeige: Color = Color(red: 255/255, green: 246/255, blue: 235/255)
        static let beige: Color = Color(red: 249/255, green: 220/255, blue: 184/255)
    }
    
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
                .foregroundStyle(Constants.brown)
                .tint(Constants.brown)
            Spacer()
        }
        .listRowBackground(Constants.beige)
    }
}

#Preview {
    AddingExpensesView()
}
