//
//  BudgetDetailView.swift
//  someCoreData
//
//  Created by  illia on 13/12/2022.
//

import SwiftUI

struct BudgetDetailView: View {
    @ObservedObject var budget: BudgetCategory
    @State private var title: String = ""
    @State private var amount: String = ""
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    private var isFormValid: Bool {
        !title.isEmpty && !amount.isEmpty && amount.isNumeric && amount.isGreaterThan(0)
    }
    
    private func saveTransaction() {
        let transaction = Transaction(context: moc)
        transaction.title = title
        transaction.amount = Double(amount)!
        
        budget.addToTransactions(transaction)
        try? moc.save()
        // dismiss()
    }
    
    private var transactionArray: [Transaction] {
        guard let transactions = budget.transactions else {
            return []
        }
        return transactions.allObjects as! [Transaction]
    }
    private func removeTransaction( _ transaction: Transaction) {
        moc.delete(transaction)
        try?moc.save()
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(budget.amount as NSNumber, formatter: NumberFormatter.currency)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            Form {
                TextField("Title", text: $title)
                TextField("Amount", text: $amount)
            }
            
            HStack {
                Spacer()
                Button("Add transaction") {
                    saveTransaction()
                }.disabled(!isFormValid)
                Spacer()
            }
            
            
            
            HStack {
                VStack(spacing: -10) {
                    Text("All:")
                    if budget.transactionsTotal > budget.amount {
                        Text(budget.transactionsTotal as NSNumber, formatter: NumberFormatter.currency)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                            .padding(.top)
                            .foregroundColor(.red)
                    } else {
                        Text(budget.transactionsTotal as NSNumber, formatter: NumberFormatter.currency)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                            .padding(.top)
                        
                    }
                }
                Spacer()
                VStack {
                    Text("I Have:")
                    Text(budget.amount - budget.transactionsTotal as NSNumber, formatter: NumberFormatter.currency)
                }
                Spacer()
            }.padding(.top, -5)
            
            TransactionListView(transactions: transactionArray, onDelete: { transaction in
                removeTransaction(transaction)
            })
            
        }.padding()
    }
}

struct BudgetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let vc = CoreDataManager.shared.persistantContainer.viewContext
        let request = BudgetCategory.fetchRequest()
        let results = try! vc.fetch(request)
        NavigationStack {
            BudgetDetailView(budget: results[0])
                .environment(\.managedObjectContext, vc)
        }
    }
}
