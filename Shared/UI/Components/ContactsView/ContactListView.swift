import SwiftUI

struct ContactListView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var contactsState: ContactsState
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Your").font(.system(size: 30)).fontWeight(.bold).zIndex(1)
                    Text("Contacts").font(.system(size: 30)).fontWeight(.light).zIndex(1)
                    Spacer()
                }
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(contactsState.getContactCategories(), id: \.self) { categorie in
                        ContactVerticalListView(categorie: categorie)
                    }
                }
            }.zIndex(1)
            Rectangle().foregroundColor(colorScheme == .dark ? Color.chimpDarkBackground : Color.chimpLightBackground)
        }.frame(width: 230).padding(.top, 20).padding(.trailing, 20).padding(.top, 20)
    }
}

struct ContactListView_Previews : PreviewProvider {
    static var previews: some View {
        CoreDataService.shared.changeToDevelopmentMode()
        return ContactListView()
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