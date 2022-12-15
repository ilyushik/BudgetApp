//
//  someCoreDataApp.swift
//  someCoreData
//
//  Created by  illia on 13/12/2022.
//

import SwiftUI

@main
struct someCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.persistantContainer.viewContext)
        }
    }
}
