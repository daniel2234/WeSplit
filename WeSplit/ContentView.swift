//
//  ContentView.swift
//  WeSplit
//
//  Created by daniel on 2022-01-23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    //property observer
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2) //count from 2 due index being zero
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmountCheck : Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let totalAmountForTheCheck = orderAmount + tipValue
        
        return totalAmountForTheCheck
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
                }
                
                Section {
                    Text("$\(totalAmountCheck, specifier: "%.2f")")
                } header: {
                    Text("Total Amount for the check")
                }

                
                Section {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                } header: {
                    Text("Amount per person")
                }

                
                Picker("Number of People", selection: $numberOfPeople) {
                    ForEach(2..<100){
                        Text("\($0) people")
                    }
                }
                
                Section(content: {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }, header: {
                    Text("How much tip do you want to leave?")
                })
            }.navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
