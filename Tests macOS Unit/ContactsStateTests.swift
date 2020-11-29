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
    
//    func test_addContact() throws {
//        let contactsState = ContactsState(inManagedObjectContext: context!)
//        let contact = Contact(firstname: "firstNameUI", lastname: "lastNameUI", email: "test@test.deUI", telephone: "016284392", birthday: "123456789", company: "companyUI")
//        contactsState.addContact(contact: contact)
//        print(contactsState.contacts.count)
//        for contact in contactsState.contacts {
//            print(contact)
//        }
//    }
//    
//    func test_getAllContactsFromCD() throws {
//        XCTAssertEqual(ContactsState(inManagedObjectContext: context!).getAllContactsFromCD(inManagedObjectContext: context!), [])
//    }
//
//    func test_createNewContactCD() throws {
//        
//        let contactData = Contact(firstname: "firstName", lastname: "lastName", email: "016243829", telephone: "test@test.de", birthday: "123456789", company: "company")
//        ContactsState(inManagedObjectContext: context!).createContactCD(contactData: contactData, viewContext: context!)
//        XCTAssertEqual(ContactsState(inManagedObjectContext: context!).getAllContactsFromCD(inManagedObjectContext: context!).count, 1)
//    }
}
