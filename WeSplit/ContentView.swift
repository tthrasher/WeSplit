//
//  ContentView.swift
//  WeSplit
//  Project 1 in 100 Days of SwiftUI
//
//  Created by Terry Thrasher on 2021-04-02.
//

import SwiftUI

struct ContentView: View {
    // @State is necessary for marking the variable as something that can change within the otherwise immutable struct of the ContentView
    // private is recommended for simple properties that will only be used in this struct; private means the variable can't be accessed outside of this struct
    // @State means that the property is observed, and changes will lead to the body being invoked again (i.e. the UI will reload)
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // This is not marked with @State, I think because we aren't directly modifying it
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0 // We can typecast checkAmount as a double, but the result is optional
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson // Because the values that feed amountPerPerson are marked with @State, when they change, this will reflect the changes
    }
    
    // Challenge 2 asks me to add another section showing the total amount for the check
    var totalBill: Double {
        let preTipTotal = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let grandTotal = preTipTotal + (preTipTotal * tipSelection / 100)
        
        return grandTotal
    }
    
    var totalTip: Double {
        let preTipTotal = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let tipValue = preTipTotal * tipSelection / 100
        
        return tipValue
    }
    
    // "some" indicates that body will return exactly one view
    var body: some View {
        NavigationView { // This allows iOS to slide in a new view when the picker is used; this is necessary for declaring that we're going to have a hierarchy of views within the body
            Form {
                Section {
                    TextField("Amount", text: $checkAmount) // $ indicates a two-way binding
                        .keyboardType(.decimalPad)
                    
                    // Challenge 3 asks me to change the number of people picker to a text field with the correct keyboard type
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                    
                    /* Original lesson code:
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    */
                }
                
                Section(header: Text("What tip would you like to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Challenge 2 asks me to add another section showing the total amount for the check
                Section(header: Text("Totals")) {
                    Text("Tip: $\(totalTip, specifier: "%.2f")")
                    Text("Grand total: $\(totalBill, specifier: "%.2f")")
                }
                
                // Challenge 1 asks me to add a header to this section
                Section(header: Text("Amout per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
