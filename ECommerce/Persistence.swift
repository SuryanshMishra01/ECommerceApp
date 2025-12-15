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

        let description = container.persistentStoreDescriptions.first
        description?.setOption(true as NSNumber,
                               forKey: NSMigratePersistentStoresAutomaticallyOption)
        description?.setOption(true as NSNumber,
                               forKey: NSInferMappingModelAutomaticallyOption)

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Core Data failed: \(error), \(error.userInfo)")
            }
        }

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
