//
//  personal_wealth_managerApp.swift
//  personal_wealth_manager
//
//  Created by dsu_student on 2025/12/02.
//

import SwiftUI
import CoreData 
//import SwiftData

@main
struct personal_wealth_managerApp: App {
    let persistenceController = PersistenceController.shared 
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
        .modelContainer(for: [Expense.self, Category.self])
    }
}
