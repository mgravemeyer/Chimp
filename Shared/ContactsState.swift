//
//  ContactsState.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 02.09.20.
//

import Foundation

class ContactsState: ObservableObject {
    
    @Published private(set) var contacts = [Contact]()
    
    func addContact(name: String) {
        contacts.append(Contact(name: name))
    }
    
}
