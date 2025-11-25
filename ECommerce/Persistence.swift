//
//  Persistence.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

internal import CoreData

@MainActor
struct PersistenceController {
    static let shared = PersistenceController()

 

    let container: NSPersistentContainer
  

    init() {
        container = NSPersistentContainer(name: "ECommerce")
     
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                print("Error loading persistent store: \(error.localizedDescription)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true

        
    }
    
    func save (context: NSManagedObjectContext) throws{
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Unresolved error \(error)")
            }
        }
        
    }
}
