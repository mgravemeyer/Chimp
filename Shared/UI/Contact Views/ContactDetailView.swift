import SwiftUI

struct ContactDetailView: View {
    
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
                        contactsState.addMenuePressed.toggle()
                    }
                }.padding(.bottom, 20)
                    ContactsDetailContactRow(selectedContact: contact).padding(.bottom, 12)
                    ContactsDetailInformation(selectedContact: contact).padding(.bottom, 12)
                    ContactsDetailTagRow(selectedContact: contact).padding(.bottom, 12)
                Spacer()
            }.zIndex(1)
            Rectangle().foregroundColor(Color.white).zIndex(0)
        }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 40)
    }
}

struct ContactsDetailContactRow: View {
    var selectedContact: Contact
    var body: some View {
        HStack {
            Button("✉️ \(selectedContact.email)") {
                NSWorkspace.shared.open(URL(string: "mailto:\(selectedContact.email)")!)
            }
            Button("📞 \(selectedContact.telephone)") {
                NSWorkspace.shared.open(URL(string: "tel://\(selectedContact.telephone)")!)
            }
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
