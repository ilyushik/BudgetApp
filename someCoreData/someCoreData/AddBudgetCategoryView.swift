//
//  AddBudgetCategoryView.swift
//  someCoreData
//
//  Created by  illia on 13/12/2022.
//

import SwiftUI

struct AddBudgetCategoryView: View {
    
    @State private var name: String = ""
    @State private var amount: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    var isFormValid: Bool {
        !name.isEmpty && !amount.isEmpty && amount.isNumeric && amount.isGreaterThan(0)
    }
    
    private func saveBudgetCategory() {
        let budg = BudgetCategory(context: moc)
        budg.name = name
        budg.amount = Double(amount)!
        
        try?moc .save()
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $name)
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if isFormValid {
                            saveBudgetCategory()
                        }
                    }.disabled(!isFormValid)
                }
            }
        }
    }
}

struct AddBudgetCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddBudgetCategoryView()
        }
    }
}
