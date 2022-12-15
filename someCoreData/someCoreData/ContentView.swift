//
//  ContentView.swift
//  someCoreData
//
//  Created by  illia on 13/12/2022.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(fetchRequest: BudgetCategory.all) private var budgetCategories: FetchedResults<BudgetCategory>
    @State private var addNewCategory: Bool = false
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(budgetCategories) { budget in
                        NavigationLink {
                            BudgetDetailView(budget: budget)
                        } label: {
                            HStack {
                                Text(budget.name ?? "")
                                Spacer()
                                Text(budget.amount as NSNumber, formatter: NumberFormatter.currency)
                            }.padding(.horizontal)
                        }
                        
                        
                    }.onDelete(perform: deleteBudget)
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addNewCategory.toggle()
                    } label: {
                        Text("Add new category")
                    }

                }
            }.sheet(isPresented: $addNewCategory) {
                AddBudgetCategoryView()
            }
        }
    }
    
    func deleteBudget(at offsets: IndexSet) {
        for offset in offsets {
            let budg = budgetCategories[offset]
            moc.delete(budg)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.persistantContainer.viewContext)
        }
    }
}
