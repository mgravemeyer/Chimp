//
//  ContactCoreDataTest.swift
//  Tests macOS Unit
//
//  Created by Maximilian Gravemeyer on 18.11.20.
//

import XCTest
@testable import Chimp

class ContactsStateTests: XCTestCase {

    override func setUpWithError() throws {
        CoreDataManager.shared.changeToDevelopmentMode()
        continueAfterFailure = true
    }
    
    func test_addContact() throws {
        let contactsState = ContactsState()
        let contact = Contact(firstname: "firstNameUI", lastname: "lastNameUI", email: "test@test.deUI", telephone: "016284392", birthday: "123456789", company: "companyUI")
        contactsState.addContact(contact: contact)
        print(contactsState.contacts.count)
        for contact in contactsState.contacts {
            print(contact)
        }
    }

    func test_getAllContactsFromCD() throws {
        XCTAssertEqual(ContactsState().getAllContactsFromCD(), [])
    }

    func test_createNewContactCD() throws {

        let contactData = Contact(firstname: "firstName", lastname: "lastName", email: "016243829", telephone: "test@test.de", birthday: "123456789", company: "company")
        ContactsState().createContactCD(contactData: contactData)
        XCTAssertEqual(ContactsState().getAllContactsFromCD().count, 1)
    }
}
