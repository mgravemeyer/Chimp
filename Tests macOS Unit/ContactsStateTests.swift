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
    
    func test_
}
