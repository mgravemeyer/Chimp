//
//  Tests_macOS_Unit.swift
//  Tests macOS Unit
//
//  Created by Maximilian Gravemeyer on 17.11.20.
//

import XCTest
@testable import Chimp

class AuthStateTests: XCTestCase {
    
    private var context: NSManagedObjectContext?

    override func setUpWithError() throws {
        self.context = NSManagedObjectContext.contextForTests()
        continueAfterFailure = false
    }
}
