import SwiftUI

struct AppView: View {
    @EnvironmentObject var contactsState: ContactsState
    @EnvironmentObject var authState: AuthState
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
    @ObservedObject static var authSate = AuthState()
    @ObservedObject static var contactsState = ContactsState()
    init() {
        CoreDataManager.shared.changeToDevelopmentMode()
    }
    static var previews: some View {
        HStack {
            AppView().environmentObject(authSate).environmentObject(contactsState)
        }
    }
}
#endif
