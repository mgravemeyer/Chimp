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
    
    init() {
        fetchContacts()
    }
    
    //Default "flow" of data saving:
    //CoreData first -> then to DB*
    
    //* via REST API (backend services)
    
    @Published private(set) var contacts = [Contact]()
    @Published var addMenuePressed = false
    @Published var advancedMenuePressed = false
    @Published var selectedContact = ""
    
    
    func fetchContacts() {
        self.contacts.append(contentsOf: getAllContactsFromCD())
    }
    
    //getting all contacts from CoreData
    func getAllContactsFromCD() -> [Contact] {
        let contactsCD = CoreDataManager.instance.fetchRecordsForEntity("ContactDetail", inManagedObjectContext: PersistenceController.shared.container.viewContext)
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
    func createContactCD(contactData: [String:String],contactsDetail: FetchedResults<ContactDetail> ,viewContext: NSManagedObjectContext) {
        let newContactDetail = ContactDetail(context: viewContext)
        for data in contactData{
            if data.key == "dob"{
                newContactDetail.setValue(Int(data.value), forKey: data.key)
            }else{
                newContactDetail.setValue(data.value, forKey: data.key)
            }
        }
        CoreDataManager.instance.save(viewContext: viewContext) { (done) in
            if(done){
                print(done)
            }
        }
        let dob = Int(Int(contactData["dob"]!)!/1000) // (Integer/Epoch format View)
        let dob_date = Date(timeIntervalSince1970: TimeInterval(dob)) // date format (to be converted to str)
        let dob_str = dob_date.toString(dateFormat: "dd.MM.YYYY")//Str format, for UI
        addContact(firstname: contactData["first_name"]!, lastname: contactData["last_name"]!, email: contactData["email"]!, telephone: contactData["phone"]!, birthday:dob_str, company: "")
    }
    
    //UI
    func addContact(firstname: String, lastname: String, email: String, telephone: String, birthday: String, company: String) {
        contacts.append(Contact(firstname: firstname, lastname: lastname, email: email, telephone: telephone, birthday: birthday, company: company))
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
