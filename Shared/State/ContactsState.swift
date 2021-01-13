import Foundation
import CoreData
import SwiftUI



class ContactsState: ObservableObject {
    private let contactService = ContactService.instance

    init() {
        fetchContacts()
    }
    
    @Published private(set) var contacts = Set<Contact>()
    @Published private(set) var addMenuePressed = false
    @Published private(set) var advancedMenuePressed = false
    @Published private(set) var selectedContact = ""
    
    func pressAddMenue() {
        addMenuePressed.toggle()
    }
    
    func pressAdvancedMenu() {
        advancedMenuePressed.toggle()
    }
    
    func selectContact(contact: String) {
        selectedContact = contact
    }
    
    func fetchContacts() {
        let fetchResult = CoreDataService.shared.fetchContacts()
        if fetchResult.0 == nil {
            self.contacts.formUnion(fetchResult.1)
        }
        /* to:do error handling */
    }
    
    func createContact(contact: Contact) {
        let saveResult = CoreDataService.shared.saveContact(contactData: contact)
        if saveResult == nil {
            contacts.insert(contact)
            contactService.addContact(contact: contact) // saving to DB via API service call

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
        if let contact = contacts.first(where: {$0.id == self.selectedContact}) {
            return contact
        } else {
            /* to:do throw error message to frontend */
            return Contact(id: "error", firstname: "error", lastname: "error", email: "error", phone: "error", dob: "error", note: "error", company_uids: [], tag_uids:[], project_uids: [])
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
