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
    private var contactsState = ContactsState()

    override func setUpWithError() throws {
        self.context = NSManagedObjectContext.contextForTests()
        continueAfterFailure = true
    }
    
    func test_getAllContactsFromCD() throws {
        XCTAssertEqual(contactsState.getAllContactsFromCD(inManagedObjectContext: context!), [])
    }
    
    func test_createNewContactCD() throws {
        let contactData = ["first_name": "firstName", "last_name": "lastName", "phone": "0162434343", "email": "test@test.de", "dob": "123456789", "note": "testNote"]
        contactsState.createContactCD(contactData: contactData, viewContext: context!)
    }
}
