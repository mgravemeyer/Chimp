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
        let fetchResult = CoreDataManager.shared.fetch("ContactDetail")
        XCTAssertEqual(fetchResult.1.count, 0)
    }
    
    func test_save_load_data() throws {
        _ = ContactDetail()
        let saveResult = CoreDataManager.shared.save()
        if(saveResult == nil) {
            XCTAssertNotNil(CoreDataManager.shared.fetch("ContactDetail"), "saved data into coreData")
        } else {
            let fetchResult = CoreDataManager.shared.fetch("ContactDetail")
            XCTAssertEqual(fetchResult.1.count, 1, "couldn't save data into coreData")
        }
    }
}
