//
//  PersistenceController.swift
//  Chimp
//
//  Created by Sean on 25.10.20.
//

import Foundation
import CoreData

class PersistenceController{
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    var objectContext: NSManagedObjectContext
    private init(){
        container = NSPersistentContainer(name: "Chimp")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error to load persistent store: \(error)")
            }
            //core data stack is ready to be used
        }
        objectContext = container.viewContext
    }
    func changeToDevelopmentMode() {
        objectContext = NSManagedObjectContext.contextForTests()
    }
}

//create in-memory CoreData stack for tests
extension NSManagedObjectContext {
    class func contextForTests() -> NSManagedObjectContext {
        // Get the model
        let model = NSManagedObjectModel.mergedModel(from: Bundle.allBundles)!
        // Create and configure the coordinator
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! coordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        
        // Setup the context
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }
}
