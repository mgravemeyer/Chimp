//
//  CoreDataManagerTests.swift
//  Tests macOS Unit
//
//  Created by Maximilian Gravemeyer on 19.11.20.
//

import XCTest
@testable import Chimp

class CoreDataManagerTests: XCTestCase {
    
    private var context: NSManagedObjectContext?

    override func setUpWithError() throws {
        self.context = NSManagedObjectContext.contextForTests()
        continueAfterFailure = true
    }
    
    func test_init() throws {
        let instance = CoreDataManager.shared
        XCTAssertNotNil(instance)
    }

    func test_save_data() throws {
        _ = ContactDetail(context: self.context!)
        CoreDataManager.shared.save(viewContext: self.context!) { (done) in
            if(done) {
                XCTAssertTrue(true, "saved data into coreData")
                print("true")
            } else {
                XCTAssertTrue(false, "couldn't save data into coreData")
            }
        }
    }
    
    func test_load_data() throws {
        XCTAssertNotNil(CoreDataManager.shared.fetchRecordsForEntity("ContactDetail", inManagedObjectContext: context!))
    }
}
