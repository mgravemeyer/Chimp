import XCTest
@testable import Chimp

class ContactsStateTests: XCTestCase {

    override func setUpWithError() throws {
        CoreDataService.shared.changeToDevelopmentMode()
        continueAfterFailure = true
    }
    
    func test_createContact() throws {

        let contactsState = ContactsState()
        XCTAssertTrue(contactsState.contacts.count == 0)
        let contact = Contact(firstname: "firstName", lastname: "lastName", email: "test@test.de", telephone: "016284392", birthday: "123456789", company: "company")
        contactsState.createContact(contact: contact)
        XCTAssertTrue(contactsState.contacts.count == 1)
        XCTAssertTrue(contactsState.contacts.contains(contact))
    }

    func test_fetchContacts() throws {
        let contactsState = ContactsState()
        contactsState.fetchContacts()
        XCTAssertEqual(contactsState.contacts, [])
    }
    
    func test_getContactCategories() throws {
        let contactsState = ContactsState()
        let contact = Contact(firstname: "firstNameUI", lastname: "lastNameUI", email: "test@test.deUI", telephone: "016284392", birthday: "123456789", company: "companyUI")
        contactsState.createContact(contact: contact)
        let categories = contactsState.getContactCategories()
        XCTAssertNotNil(categories, "no contact categories found")
        XCTAssertEqual(categories[0], "l")
    }
    
    func test_getContactsBySearch() throws {
        let contactsState = ContactsState()
        let searchResultEmpty = contactsState.getContactsBySearch(search: "l")
        XCTAssertEqual(searchResultEmpty, [Contact]())
        let contact = Contact(firstname: "firstNameUI", lastname: "lastNameUI", email: "test@test.deUI", telephone: "016284392", birthday: "123456789", company: "companyUI")
        contactsState.createContact(contact: contact)
        let searchResult = contactsState.getContactsBySearch(search: "f")
        XCTAssertFalse(searchResult.count == 0)
        XCTAssertTrue(contactsState.contacts.contains(searchResult[0]))
    }
}
 
