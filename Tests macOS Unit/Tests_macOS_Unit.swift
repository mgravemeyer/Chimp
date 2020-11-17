//
//  Tests_macOS_Unit.swift
//  Tests macOS Unit
//
//  Created by Maximilian Gravemeyer on 17.11.20.
//

import XCTest
@testable import Chimp

class Tests_macOS_Unit: XCTestCase {
    
    private var context: NSManagedObjectContext?

    override func setUpWithError() throws {
        self.context = NSManagedObjectContext.contextForTests()
        continueAfterFailure = false
    }
    
    func testSaveCoreData() throws {
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

//create in-memory CoreData stack for tests
extension NSManagedObjectContext {
    class func contextForTests() -> NSManagedObjectContext {
        // Get the model
        let model = NSManagedObjectModel.mergedModel(from: Bundle.allBundles)!
        // Create and configure the coordinator
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! coordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        
        // Setup the context
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }
}
