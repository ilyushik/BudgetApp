//
//  CoreDataManager.swift
//  someCoreData
//
//  Created by  illia on 13/12/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistantContainer: NSPersistentContainer
    
    private init () {
        persistantContainer = NSPersistentContainer(name: "BudgetModel")
        persistantContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to load CoreData (\(error))")
            }
        }
    }
}
