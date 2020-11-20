//
//  ContactCoreDataTest.swift
//  Tests macOS Unit
//
//  Created by Maximilian Gravemeyer on 18.11.20.
//

import XCTest
@testable import Chimp

class ContactsStateTests: XCTestCase {
    
    private var context: NSManagedObjectContext?

    override func setUpWithError() throws {
        self.context = NSManagedObjectContext.contextForTests()
        continueAfterFailure = true
    }
    
    func test_addContact() throws {
        let contactsState = ContactsState(inManagedObjectContext: context!)
        contactsState.addContact(firstname: "firstNameUI", lastname: "lastNameUI", email: "test@test.de", telephone: "123456789", birthday: "123456789", company: "testNote")
        print(contactsState.contacts.count)
        for contact in contactsState.contacts {
            print(contact)
        }
    }
    
    func test_getAllContactsFromCD() throws {
        XCTAssertEqual(ContactsState(inManagedObjectContext: context!).getAllContactsFromCD(inManagedObjectContext: context!), [])
    }

    func test_createNewContactCD() throws {
        let contactData = ["first_name": "firstName", "last_name": "lastName", "phone": "0162434343", "email": "test@test.de", "dob": "123456789", "note": "testNote"]
        ContactsState(inManagedObjectContext: context!).createContactCD(contactData: contactData, viewContext: context!)
        XCTAssertEqual(ContactsState(inManagedObjectContext: context!).getAllContactsFromCD(inManagedObjectContext: context!).count, 1)
    }
}
