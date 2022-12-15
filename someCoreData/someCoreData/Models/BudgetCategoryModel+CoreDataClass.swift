//
//  BudgetCategoryModel.swift
//  someCoreData
//
//  Created by  illia on 15/12/2022.
//

import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    
    var transactionsTotal: Double {
        guard let transactions = transactions else {
            return 0.0
        }
        let transactionsArray: [Transaction] = transactions.toArray()
        return transactionsArray.reduce(0) { result, transaction in
            result + transaction.amount
        }
    }
    
    static var all: NSFetchRequest<BudgetCategory> {
        let request = BudgetCategory.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }
}
