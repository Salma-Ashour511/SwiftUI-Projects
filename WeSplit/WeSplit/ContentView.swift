//
//  ContentView.swift
//  WeSplit
//
//  Created by V17SAshour1 on 02/05/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [0, 10, 20, 30, 40]
    
    var totalPerPerson: Double {
        let numberOfPeople = Double(numberOfPeople)
        let tipPercentage = Double(tipPercentage)
        
        let tipAmount = (checkAmount / 100) * tipPercentage
        let totalWithTip = checkAmount + tipAmount
        let amountPerPerson = totalWithTip / numberOfPeople
        
        return amountPerPerson
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                    
                    Picker("How many people?", selection: $numberOfPeople) {
                        ForEach(2..<51) { number in
                            Text("\(number) people")
                        }
                    }
                }
                
                Section("How much do you want to tip") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { tip in
                            Text(tip, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }.navigationTitle("We Split")
        }
    }
}


#Preview {
    ContentView()
}
