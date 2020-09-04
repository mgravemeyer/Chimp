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
    
    func addContact(firstname: String, lastname: String) {
        contacts.append(Contact(firstname: firstname, lastname: lastname))
    }
    
}
