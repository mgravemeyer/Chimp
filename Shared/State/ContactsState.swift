import Foundation
import CoreData
import SwiftUI



class ContactsState: ObservableObject {
    private let contactService = ContactService.instance
    private let authState = AuthState.instance

    init() {
        fetchContacts()
    }
    
    @Published private(set) var contacts = Set<Contact>()
    @Published private(set) var addMenuePressed = false
    @Published private(set) var advancedMenuePressed = false
    @Published private(set) var selectedContact = ""
    @Published var selectedMenue = ""
    @Published var search = ""
    
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
            addContactToBackend(contact: contact)
            
        }
        /* to:do error handling */
    }
    
    func addContactToBackend(contact: Contact){
        // this is refactored to a new func
        // instead of in the createContact() func (above)
        // is so that it's easier to call it recursively
        
        contactService.addContact(contact: contact) { [unowned self] (result) in // saving to DB via API service call
            switch result{
            case .success(let x):
                print(x)
            case .failure(let err):
                print(err.localizedDescription)
                if(err.localizedDescription == "TokenExpired"){
                    authState.setNewAccessToken { (success) in
                        if(success){
                            addContactToBackend(contact: contact) // re-hits the add contact endpt here
                        }
                    }
                }
                
            }
        }
        
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
