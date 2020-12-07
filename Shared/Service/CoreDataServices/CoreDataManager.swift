import Foundation
import CoreData
import SwiftUI

enum CoreDataErrors: String, Error {
    case fetchError = "Couldnt fetch data from coreData"
    case saveError = "Couldnt save data to coreData"
}

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
    
    func fetchContacts() -> (CoreDataErrors?, [Contact]) {
        let contactsCD = fetch("ContactDetail")
        //to:do unwrap values safely, not force unwrap
        if contactsCD.0 == nil {
            var contactsFetched = [Contact]()
            for result in contactsCD.1 as [NSManagedObject] {
                let firstName = result.value(forKey: "first_name") as! String
                let lastName = result.value(forKey: "last_name") as! String
                let email = result.value(forKey: "email") as! String
                let phone = result.value(forKey: "phone") as! String
                var dob = Int()
                if let dobOptional = result.value(forKey: "dob") as? Int {
                    dob = dobOptional
                } else {
                    dob = 123456789
                }
                let dob_date = Date(timeIntervalSince1970: TimeInterval(dob))
                let dob_str = dob_date.toString(dateFormat: "dd.MM.YYYY")
                
                let contact = Contact(firstname: firstName, lastname: lastName, email: email, telephone: phone, birthday: dob_str, company: "")
                contactsFetched.append(contact)
            }
            return (nil, contactsFetched)
        } else {
            return (.fetchError, [Contact]())
        }
    }
    
    func saveContact(contactData: Contact) -> CoreDataErrors? {
        var modifiedBirthdayContact = contactData
        
        let newContactDetail = ContactDetail(context: CoreDataManager.shared.viewContext)
        
        //to:do for loop adding values
        newContactDetail.setValue(contactData.firstname, forKey: "first_name")
        newContactDetail.setValue(contactData.lastname, forKey: "last_name")
        newContactDetail.setValue(contactData.email, forKey: "email")
        newContactDetail.setValue(Int(contactData.birthday), forKey: "dob")
        //to:do change note to get from contact
        newContactDetail.setValue("note", forKey: "note")
        newContactDetail.setValue(contactData.telephone, forKey: "phone")
        
        let saveResult = save()
        if saveResult == nil {
            return nil
        } else {
            return .saveError
        }
    }
    
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
