//
//  Tests_macOS_Unit.swift
//  Tests macOS Unit
//
//  Created by Maximilian Gravemeyer on 17.11.20.
//

import XCTest
@testable import Chimp

class AuthCoreDataTests: XCTestCase {
    
    private var context: NSManagedObjectContext?

    override func setUpWithError() throws {
        self.context = NSManagedObjectContext.contextForTests()
        continueAfterFailure = false
    }
    
    func test_init_coreDataManager() throws {
        let instance = CoreDataManager.instance
        XCTAssertNotNil(instance)
    }
    
    func test_load_persistent_container() throws {
        XCTAssertNoThrow(PersistenceController.shared.container.loadPersistentStores, "loaded persistenceController")
    }
}
