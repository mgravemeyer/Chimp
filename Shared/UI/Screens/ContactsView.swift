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
        CoreDataManager.shared.changeToDevelopmentMode()
        return ContactsView()
            .environmentObject({ () -> ContactsState in
            let contactsState = ContactsState()
                contactsState.createContact(contact: Contact(firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "tLongFirstName", lastname: "tLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            return contactsState
        }())
    }
}
