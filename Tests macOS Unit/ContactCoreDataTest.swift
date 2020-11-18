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
        continueAfterFailure = false
    }
    
    func test_init_coreDataManager() throws {
        let instance = CoreDataManager.instance
        XCTAssertNotNil(instance)
    }
    
    func test_load_persistent_container() throws {
        XCTAssertNoThrow(PersistenceController.shared.container.loadPersistentStores, "loaded persistenceController")
    }

    func test_save_new_contact() throws {
        let newContactDetail = ContactDetail(context: self.context!)
        newContactDetail.dob = 12345678901
        newContactDetail.email = "test@test.com"
        newContactDetail.first_name = "First"
        newContactDetail.last_name = "Last"
        newContactDetail.note = "Test Note"
        
        CoreDataManager.instance.save(viewContext: self.context!) { (done) in
            if(done) {
                XCTAssertTrue(true, "saved data into coreData")
                print("true")
            } else {
                XCTAssertTrue(false, "couldn't save data into coreData")
            }
        }
    }

}
