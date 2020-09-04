//
//  ContactsState.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 02.09.20.
//

import Foundation

import Foundation

class ContactsState: ObservableObject {
    
    @Published private(set) var contacts = [Contact]()
    @Published var addMenuePressed = false
    
    func addContact(firstname: String, lastname: String) {
        contacts.append(Contact(firstname: firstname, lastname: lastname))
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
    
}
