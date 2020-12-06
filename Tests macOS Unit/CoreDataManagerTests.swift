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

    func test_load_empty_data() throws {
        let fetchResult = CoreDataManager.shared.fetch("ContactDetail")
        XCTAssertEqual(fetchResult.0, nil)
        XCTAssertEqual(fetchResult.1.count, 0)
    }
    
    func test_save_load_data() throws {
        let contact = ContactDetail()
        let saveResult = CoreDataManager.shared.save()
        XCTAssertNil(saveResult, "no errors appeared while saving data into coreData")
        XCTAssertNotNil(CoreDataManager.shared.fetch("ContactDetail"), "saved data into coreData")
        let fetchResult = CoreDataManager.shared.fetch("ContactDetail")
        XCTAssertEqual(fetchResult.1.count, 1, "couldn't save data into coreData")
    }
}
