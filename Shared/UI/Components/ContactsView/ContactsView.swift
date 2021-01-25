import SwiftUI

struct ContactsView: View {
    
    @EnvironmentObject var contactsState: ContactsState

    let url = Bundle.main.url(forResource: "Images/grapes", withExtension: "png")
    
    var body: some View {
        HStack {
            ContactListView()
            if contactsState.selectedContact == "" {
                EmptyContactDetail()
            } else {
                ContactDetailView(contact: contactsState.getSelectedContact())
            }
        }
    }
}

struct ContactsView_Previews : PreviewProvider {
    static var previews: some View {
        CoreDataService.shared.changeToDevelopmentMode()
        return ContactsView()
            .environmentObject({ () -> ContactsState in
            let contactsState = ContactsState()
                contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
                contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
                contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
                contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
                contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            return contactsState
        }())
    }
}
