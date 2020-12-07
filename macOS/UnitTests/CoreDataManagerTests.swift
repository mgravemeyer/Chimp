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
    
    func test_save_data() throws {
        _ = ContactDetail(context: CoreDataManager.shared.viewContext)
        let saveResult = CoreDataManager.shared.save()
        XCTAssertNil(saveResult, "couldn't save data into coreData")
    }
    
    func test_save_load_data() throws {
        let contact = ContactDetail(context: CoreDataManager.shared.viewContext)
        let saveResult = CoreDataManager.shared.save()
        XCTAssertNil(saveResult, "couldn't save data into coreData")
        let fetchResult = CoreDataManager.shared.fetch("ContactDetail")
        XCTAssertNotNil(fetchResult, "couldn't fetch data from coreData")
        XCTAssertEqual(fetchResult.1.count, 1, "fetched result should hold 1 object after saving, but has not 1")
        XCTAssertEqual(contact, (fetchResult.1)[0], "contactDetail object is not the same as saved")
    }
}
