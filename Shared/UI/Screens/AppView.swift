import SwiftUI

struct AppView: View {
    
    @EnvironmentObject var authState: AuthState
    @EnvironmentObject var contactsState: ContactsState
    
    var body: some View {
        ZStack {
            Color.white
            HStack {
                SideNavigationView().environmentObject(authState)
                VStack {
                    ContactsView()
                }
            }
        }.frame(minWidth: 900, minHeight: 500)
    }
}

#if DEBUG
struct AppView_Previews : PreviewProvider {
    static var previews: some View {
        CoreDataService.shared.changeToDevelopmentMode()
        return VStack {
            AppView()
        }
        .environmentObject(AuthState())
        .environmentObject({ () -> ContactsState in
            let contactsState = ContactsState()
                contactsState.createContact(contact: Contact(firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "tLongFirstName", lastname: "tLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            contactsState.createContact(contact: Contact(firstname: "SEvenLongerFirstName", lastname: "SEvenLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            contactsState.createContact(contact: Contact(firstname: "SEvenLongerFirstName", lastname: "SEvenLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            contactsState.createContact(contact: Contact(firstname: "SEvenLongerFirstName", lastname: "SEvenLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            contactsState.createContact(contact: Contact(firstname: "ZEvenLongerFirstName", lastname: "ZEvenLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            contactsState.createContact(contact: Contact(firstname: "ZEvenLongerFirstName", lastname: "ZEvenLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            return contactsState
        }())
    }
}
#endif
