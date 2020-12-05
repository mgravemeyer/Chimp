import XCTest
@testable import Chimp

class ContactsStateTests: XCTestCase {

    override func setUpWithError() throws {
        CoreDataManager.shared.changeToDevelopmentMode()
        continueAfterFailure = true
    }
    
    func test_addContact() throws {
        let contactsState = ContactsState()
        let contact = Contact(firstname: "firstNameUI", lastname: "lastNameUI", email: "test@test.deUI", telephone: "016284392", birthday: "123456789", company: "companyUI")
        contactsState.addContact(contact: contact)
        for contact in contactsState.contacts {
            print(contact)
        }
    }

    func test_fetchContacts() throws {
        let contactsState = ContactsState()
        contactsState.fetchContacts()
        XCTAssertEqual(contactsState.contacts, [])
    }
}
