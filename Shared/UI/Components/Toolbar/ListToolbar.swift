import SwiftUI

struct ListToolbar: View {
    @EnvironmentObject var contactsState: ContactsState
    var body: some View {
        HStack {
            TextField("Search", text: $contactsState.search)
            Button(action: {
                contactsState.selectedMenue = "Companies"
            }, label: {
                Text("Comp")
            })
            Button(action: {
                contactsState.selectedMenue = "Contacts"
            }, label: {
                Text("Cont")
            })
        }
    }
}
