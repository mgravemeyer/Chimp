//
//  ContactsState.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 02.09.20.
//

import Foundation

import Foundation

class ContactsState: ObservableObject {
    
    init() {
        contacts.append(Contact(firstname: "Felix", lastname: "Something", email: "felix@test.de", telephone: "123", birthday: "01.02.2000", company: "Chimp"))
        contacts.append(Contact(firstname: "Paul", lastname: "Something", email: "paul@test.de", telephone: "123", birthday: "01.02.2000", company: "Chimp"))
        contacts.append(Contact(firstname: "Richard", lastname: "Macbook", email: "richard@test.de", telephone: "123", birthday: "01.02.2000", company: "Chimp"))
        contacts.append(Contact(firstname: "Ricardo", lastname: "Macbook", email: "ricardo@test.de", telephone: "123", birthday: "01.02.2000", company: "Chimp"))
        contacts.append(Contact(firstname: "Ruculalo", lastname: "Macbook", email: "ruculalo@test.de", telephone: "123", birthday: "01.02.2000", company: "Chimp"))
        contacts.append(Contact(firstname: "Noah", lastname: "Magel", email: "noah@test.de", telephone: "123", birthday: "01.02.2000", company: "Chimp"))
        contacts.append(Contact(firstname: "Sean", lastname: "Magel", email: "sean@test.de", telephone: "123", birthday: "01.02.2000", company: "Chimp"))
        contacts.append(Contact(firstname: "Max", lastname: "Magel", email: "max@test.de", telephone: "123", birthday: "01.02.2000", company: "Chimp"))
        contacts.append(Contact(firstname: "Frederic", lastname: "Magel", email: "frederic@test.de", telephone: "123", birthday: "01.02.2000", company: "Chimp"))
    }
    
    @Published private(set) var contacts = [Contact]()
    @Published var addMenuePressed = false
    @Published var advancedMenuePressed = false
    @Published var selectedContact = ""
    
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
    
}
