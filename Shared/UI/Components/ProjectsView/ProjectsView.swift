import SwiftUI

struct ProjectsView: View {
    
    @EnvironmentObject var contactsState: ContactsState
    
    var body: some View {
        HStack {
            ProjectListView()
            ProjectDetailView()
        }
    }
}

#if DEBUG
struct ProjectsView_Previews : PreviewProvider {
    static var previews: some View {
        CoreDataService.shared.changeToDevelopmentMode()
        return ProjectsView()
        .environmentObject(AuthState())
        .environmentObject(ContactsState())
        .environmentObject(ProjectsState())
        
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
#endif
