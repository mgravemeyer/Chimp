import Foundation
import CoreData
import SwiftUI



class ContactsState: ObservableObject {
    
    init() {
        fetchContacts()
    }
    
    @Published private(set) var contacts = Set<Contact>()
    @Published var addMenuePressed = false
    @Published var advancedMenuePressed = false
    @Published var selectedContact = ""
    
    
    func fetchContacts() {
        let fetchResult = CoreDataManager.shared.fetchContacts()
        if fetchResult.0 == nil {
            self.contacts.formUnion(fetchResult.1)
        }
        /* to:do error handling */
    }
    
    func createContact(contact: Contact) {
        let saveResult = CoreDataManager.shared.saveContact(contactData: contact)
        if saveResult == nil {
            /* to:do save contact via api */
            contacts.insert(contact)
        }
        /* to:do error handling */
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
