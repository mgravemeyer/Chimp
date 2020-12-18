import SwiftUI

struct ContactDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var contactsState: ContactsState
    var contact: Contact
    
        var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                HStack {
                    Text(contact.firstname).font(.system(size: 30)).fontWeight(.light)
                    Text(contact.lastname).font(.system(size: 30)).fontWeight(.bold)
                    Spacer()
                    Button("Add Contact") {
                        contactsState.pressAddMenue()
                    }
                }.padding(.bottom, 20)
                ContactsDetailContactRow(selectedContact: contact)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 10)
                    ContactsDetailTagRow(selectedContact: contact).padding(.bottom, 12)
                Spacer()
            }.zIndex(1)
            Rectangle().foregroundColor(colorScheme == .dark ? Color.chimpDarkBackground : Color.chimpLightBackground).zIndex(0)
        }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 40)
    }
}

struct ContactDetailView_Previews : PreviewProvider {
    static var previews: some View {
        CoreDataService.shared.changeToDevelopmentMode()
        return ContactDetailView(contact: Contact(firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            .environmentObject(ContactsState())
    }
}

struct ContactsDetailContactRow: View {
    var selectedContact: Contact
    var body: some View {
        HStack {
            Button(action: {
                NSWorkspace.shared.open(URL(string: "mailto:\(selectedContact.email)")!)
            }, label: {
                HStack {
                    Image(systemName: "envelope").foregroundColor(Color.chimpPrimary)
                    Text(selectedContact.email).foregroundColor(Color.chimpLightText).padding(.leading, -5)
                }
            })
            Button(action: {
                NSWorkspace.shared.open(URL(string: "tel://\(selectedContact.telephone)")!)
            }, label: {
                HStack {
                    Image(systemName: "phone").foregroundColor(Color.chimpPrimary)
                    Text(selectedContact.telephone).foregroundColor(Color.chimpLightText).padding(.leading, -5)
                }
            })
        }
    }
}

struct ContactsDetailInformation: View {
    var selectedContact: Contact
    var body: some View {
        HStack {
            Text("🎂 \(selectedContact.birthday)")
            Text("🏢 \(selectedContact.company)")
        }
    }
}

struct ContactsDetailTagRow: View {
    var selectedContact: Contact
    var body: some View {
        HStack {
            TagView(tagText: "Tag One")
            TagView(tagText: "Tag Two")
        }
    }
}
