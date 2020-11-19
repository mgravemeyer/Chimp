//
//  ContactCoreDataTest.swift
//  Tests macOS Unit
//
//  Created by Maximilian Gravemeyer on 18.11.20.
//

import XCTest
@testable import Chimp

class ContactCoreDataTest: XCTestCase {
    
    private var context: NSManagedObjectContext?

    override func setUpWithError() throws {
        self.context = NSManagedObjectContext.contextForTests()
        continueAfterFailure = true
    }
}
