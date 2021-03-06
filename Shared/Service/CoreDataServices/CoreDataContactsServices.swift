import Foundation
import CoreData
import SwiftUI

extension CoreDataService {
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
                let contact = Contact(id: UUID().uuidString, firstname: firstName, lastname: lastName, email: email, phone: phone, dob: dob_str, note: "", company_uids: [], tag_uids: [], project_uids: [])
                contactsFetched.append(contact)
            }
            return (nil, contactsFetched)
        } else {
            return (.fetchError, [Contact]())
        }
    }
    
    func saveContact(contactData: Contact) -> CoreDataErrors? {
        let newContactDetail = ContactDetail(context: CoreDataService.shared.viewContext)
        //to:do for loop adding values
        newContactDetail.setValue(contactData.firstname, forKey: "first_name")
        newContactDetail.setValue(contactData.lastname, forKey: "last_name")
        newContactDetail.setValue(contactData.email, forKey: "email")
        newContactDetail.setValue(Int(contactData.dob), forKey: "dob")
        newContactDetail.setValue("note", forKey: "note")
        newContactDetail.setValue(contactData.phone, forKey: "phone")
        
        let saveResult = save()
        if saveResult == nil {
            return nil
        } else {
            return .saveError
        }
    }
}
