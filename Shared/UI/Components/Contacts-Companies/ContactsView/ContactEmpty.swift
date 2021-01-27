import SwiftUI

struct EmptyContactDetail: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var contactsState: ContactsState
    
    var body: some View {
        ZStack() {
            Button {
                contactsState.pressAddMenue()
            } label: {
                Text("Add Contact")
            }.zIndex(2)
            Image("Contacts_Detail").resizable().frame(width: 300, height: 300).padding(.trailing, 40).zIndex(1)
            Rectangle().foregroundColor(colorScheme == .dark ? Color.chimpDarkBackground : Color.chimpLightBackground)
        }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 20)
    }
}
