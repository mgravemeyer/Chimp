//
//  ContactsState.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 02.09.20.
//

import Foundation
import CoreData
import SwiftUI



class ContactsState: ObservableObject {
    
    init(inManagedObjectContext: NSManagedObjectContext) {
        fetchContacts(inManagedObjectContext: inManagedObjectContext)
    }
    
    //Default "flow" of data saving:
    //CoreData first -> then to DB*
    
    //* via REST API (backend services)
    
    @Published private(set) var contacts = [Contact]()
    @Published var addMenuePressed = false
    @Published var advancedMenuePressed = false
    @Published var selectedContact = ""
    
    
    func fetchContacts(inManagedObjectContext: NSManagedObjectContext) {
        self.contacts.append(contentsOf: getAllContactsFromCD(inManagedObjectContext: inManagedObjectContext))
    }
    
    //getting all contacts from CoreData
    func getAllContactsFromCD(inManagedObjectContext viewContext: NSManagedObjectContext) -> [Contact] {
        let contactsCD = CoreDataManager.shared.fetch("ContactDetail", inManagedObjectContext: viewContext)
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
    
    
    //creating a new Contact in CoreData
    func createContactCD(contactData: Contact, viewContext: NSManagedObjectContext) {
        
        var modifiedBirthdayContact = contactData
        
        let newContactDetail = ContactDetail(context: viewContext)
        
        //to:do for loop adding values
        newContactDetail.setValue(contactData.firstname, forKey: "first_name")
        newContactDetail.setValue(contactData.lastname, forKey: "last_name")
        newContactDetail.setValue(contactData.email, forKey: "email")
        newContactDetail.setValue(Int(contactData.birthday), forKey: "dob")
        //to:do change note to get from contact
        newContactDetail.setValue("note", forKey: "note")
        newContactDetail.setValue(contactData.telephone, forKey: "phone")

        CoreDataManager.shared.save(viewContext: viewContext) { (done) in
            if(done){
                print(done)
            }
        }
        
        //to:do avoid data converting
        let dob = Int(Int(contactData.birthday)!/1000) // (Integer/Epoch format View)
        let dob_date = Date(timeIntervalSince1970: TimeInterval(dob)) // date format (to be converted to str)
        modifiedBirthdayContact.birthday = dob_date.toString(dateFormat: "dd.MM.YYYY")//Str format, for UI
        addContact(contact: modifiedBirthdayContact)
    }
    
    //UI
    func addContact(contact: Contact) {
        contacts.append(contact)
    }
  
    func getContactCategories() -> [String] {
        var categories = Set<String>()
        for contact in self.contacts {
            let categoriesString = String(contact.lastname.first!)
            categories.insert(categoriesString)
        }
        var categoriesString = Array(categories)
        categoriesString = categoriesString.sorted { $0.first!.lowercased() < $1.first!.lowercased() }
        return categoriesString
    }
    
    func getSelectedContact() -> Contact {
        if let contact = contacts.first(where: {$0.id.uuidString == self.selectedContact}) {
            return contact
        } else {
            return Contact(firstname: "error", lastname: "error", email: "error", telephone: "error", birthday: "error", company: "error")
        }
    }
    
    func getContactsBySearch(search: String) -> [Contact] {
        var result = [Contact]()
        for contact in self.contacts {
            if (contact.firstname.lowercased().hasPrefix(search) && search != "" || contact.firstname.uppercased().hasPrefix(search) && search != "") {
                result.append(contact)
            }
        }
        return result
    }
    
}
