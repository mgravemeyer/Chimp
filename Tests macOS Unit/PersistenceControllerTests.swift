//
//  PersistenceControllerTests.swift
//  Tests macOS Unit
//
//  Created by Maximilian Gravemeyer on 19.11.20.
//

import XCTest
@testable import Chimp

class PersistenceControllerTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = true
    }
    
    func test_init() throws {
        let instance = PersistenceController.shared
        XCTAssertNotNil(instance)
    }
    
    func test_load_container() throws {
        XCTAssertNoThrow(PersistenceController.shared.container.loadPersistentStores, "loaded persistenceController")
    }

}
