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
    static var previews: some View {
        HStack {
            PreviewCoreDataWrapper {
//                .environmentObject({ () -> AuthState in
//                    let authState = AuthState()
//                    authState.loggedIn = true
//                    return authState
//                }())
                AppView().environmentObject(authSate).environmentObject(contactsState)
            }
        }
    }
}
#endif
