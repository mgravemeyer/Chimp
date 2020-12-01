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
        XCTAssertNotNil(CoreDataManager.shared.viewContext)
    }
    
    //load empty data to test if coreDataManager uses the test contextView container
    func test_load_empty_data() throws {
        XCTAssertEqual(CoreDataManager.shared.fetch("ContactDetail"), [])
    }

    func test_save_data() throws {
        _ = ContactDetail()
        CoreDataManager.shared.save() { (done) in
            if(done) {
                XCTAssertNotNil(CoreDataManager.shared.fetch("ContactDetail"), "saved data into coreData")
            } else {
                XCTAssertTrue(false, "couldn't save data into coreData")
            }
        }
    }
}
