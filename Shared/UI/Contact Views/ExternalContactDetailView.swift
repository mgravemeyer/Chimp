import SwiftUI

struct ExternalContactDetailView: View {
    let contact: Contact
    let myWindow:NSWindow?
    var body: some View {
        ContactsDetailsExtraWindow(contact: contact).edgesIgnoringSafeArea(.all).padding(.leading, 10)
    }
}

//TO:DO: ADD BOTH STRUCTS TOGETHER
struct ContactsDetailsExtraWindow: View {
    
    @EnvironmentObject var contactsState: ContactsState
    var contact: Contact
    
    var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                HStack {
                    Text(contact.firstname).font(.system(size: 30)).fontWeight(.light)
                    Text(contact.lastname).font(.system(size: 30)).fontWeight(.bold)
                    Spacer()
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
