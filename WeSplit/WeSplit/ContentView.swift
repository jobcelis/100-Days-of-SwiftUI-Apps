//
//  ContentView.swift
//  WeSplit
//
//  Created by Job Celis on 1/12/24
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) + 2
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // Code made from ChatGPT
    var totalAmount: Double {
           let tipSelection = Double(tipPercentage)
           let tipValue = checkAmount / 100 * tipSelection
           let grandTotal = checkAmount + tipValue
           
           return grandTotal
       }

    
    var body: some View {
        NavigationStack {
            Form {
                
                // the check amount / number of people
                Section ("Bill Total and Party Size") {
                    Section {
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of People", selection: $numberOfPeople) {
                            ForEach(2..<11) {
                                Text("\($0) People")
                                
                            }
                        }
                    }
                }
                
                // the tipping amount
                Section ("Tipping Amount") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                
                // the total tip amount per person
                Section("Spilt Total") {
                    Section {
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))

                    }
                }
            }
            .navigationTitle("WeSplit")
            
            
            // Total Amount Spent section
                Section("Total Amount Spent") {
                    Section {
                        Text("\(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
             }
            
                
                
                // a "Done" button when your finished using the keyboard
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
}



#Preview {
    ContentView()
}
