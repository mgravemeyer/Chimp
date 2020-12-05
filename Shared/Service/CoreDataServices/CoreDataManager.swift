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
    
    func fetchContacts() -> [Contact] {
        let contactsCD = fetch("ContactDetail")
        var contactsFetched = [Contact]()
        //to:do unwrap values safely, not force unwrap
        for result in contactsCD as [NSManagedObject] {
            let firstName = result.value(forKey: "first_name") as! String
            let lastName = result.value(forKey: "last_name") as! String
            let email = result.value(forKey: "email") as! String
            let phone = result.value(forKey: "phone") as! String
            
            let dob = result.value(forKey: "dob") as! Int
            let dob_date = Date(timeIntervalSince1970: TimeInterval(dob))
            let dob_str = dob_date.toString(dateFormat: "dd.MM.YYYY")
            
            let contact = Contact(firstname: firstName, lastname: lastName, email: email, telephone: phone, birthday: dob_str, company: "")
            contactsFetched.append(contact)
        }
        return contactsFetched
    }
    
    func fetch(_ entity: String) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        var result = [NSManagedObject]()
        do {
            let records = try viewContext.fetch(fetchRequest)

            if let records = records as? [NSManagedObject] {
                result = records
            }
        } catch {
            print("Unable to fetch managed objects for entity \(entity).")
        }
        return result
    }
    
    func save(saved: @escaping (_ status: Bool)->()){
        do{
            try viewContext.save()
            saved(true)
        }catch{
            saved(false)
            let err = error as NSError
            fatalError("cData save err: \(err)")
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
