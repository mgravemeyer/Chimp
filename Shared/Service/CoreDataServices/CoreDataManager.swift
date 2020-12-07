import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
    
    private init() {
        container = NSPersistentContainer(name: "Chimp")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error to load persistent store: \(error)")
            }
            //core data stack is ready to be used
        }
        viewContext = container.viewContext
    }
    
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext
    
    func fetch(_ entity: String) -> (CoreDataErrors? ,[NSManagedObject]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        var result = [NSManagedObject]()
        do {
            let records = try viewContext.fetch(fetchRequest)

            if let records = records as? [NSManagedObject] {
                result = records
            }
        } catch {
            return (.fetchError, result)
        }
        return (nil, result)
    }
    
    func save() -> (CoreDataErrors?) {
        do{
            try viewContext.save()
            return nil
        }catch{
            return .saveError
        }
    }
    
    func changeToDevelopmentMode() {
        viewContext = NSManagedObjectContext.contextForTests()
    }
}

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
