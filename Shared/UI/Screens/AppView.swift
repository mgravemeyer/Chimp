import SwiftUI

struct AppView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var authState: AuthState
    
    @State var selection = "Contacts"
    
    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.chimpDarkBackground : Color.chimpLightBackground
            HStack {
                SideNavigationView(selection: $selection).environmentObject(authState)
                VStack {
                    if selection == "Contacts" {
                        ContactsView()
                    } else if selection == "Projects" {
                        ProjectsView()
                    }
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
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            return contactsState
        }())
    }
}
#endif
