//
//  CoreDataManagerTests.swift
//  Tests macOS Unit
//
//  Created by Maximilian Gravemeyer on 19.11.20.
//

import XCTest
@testable import Chimp

class CoreDataManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
        CoreDataManager.shared.changeToDevelopmentMode()
        continueAfterFailure = true
    }
    
    func test_init() throws {
        let instance = CoreDataManager.shared
        XCTAssertNotNil(instance)
    }
    
    func test_load_empty_data() throws {
        XCTAssertEqual(CoreDataManager.shared.fetch("ContactDetail"), [])
    }

    func test_save_data() throws {
        _ = ContactDetail()
        CoreDataManager.shared.save() { (done) in
            if(done) {
                XCTAssertTrue(true, "saved data into coreData")
                print("true")
            } else {
                XCTAssertTrue(false, "couldn't save data into coreData")
            }
        }
    }
    
    func test_load_data() throws {
        XCTAssertNotNil(CoreDataManager.shared.fetch("ContactDetail"))
    }
}
