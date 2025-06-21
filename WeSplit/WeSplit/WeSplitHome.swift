//
//  WeSplitHome.swift
//  WeSplit
//
//  Created by Hend El Mahdy on 21/06/2025.
//

import SwiftUI

struct WeSplitHome: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    private let tipPercentages = [10,15,20,25,0]
    
    private var totalAmount: Double {
        let totalTip = checkAmount * (Double(tipPercentage) / 100)
        let amount = checkAmount + totalTip
        return amount
    }
    private var amountPerPerson: Double {
        let peopleCount  = Double(numberOfPeople + 2)
        let totalPerPerson = totalAmount / peopleCount
        return totalPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Check Amount"), content: {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number Of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                })
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
//                        ForEach(0..<101) {
//                            Text($0, format: .percent)
//                        }
                    }
                    .pickerStyle(.segmented)
                    //.pickerStyle(.navigationLink)
                }
                Section("Total Check Amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(amountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    WeSplitHome()
}
