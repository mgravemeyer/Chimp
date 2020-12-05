import SwiftUI

@main
struct ChimpApp: App {
    @StateObject var authState = AuthState()
    @StateObject var contactsState = ContactsState()
    var body: some Scene {
            WindowGroup {
                AppWrapper()
                    .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
                    .environmentObject(authState)
                    .environmentObject(contactsState)
            }.windowStyle(HiddenTitleBarWindowStyle())
    }
}

struct AppWrapper: View {
    @EnvironmentObject var contactsState: ContactsState
    @EnvironmentObject var authState: AuthState
    var body: some View{
        if authState.authLoading {
            LoadingView().onAppear {
                self.authState.checkAuth()
            }
        } else {
            if !authState.loggedIn {
                LoginView()
            } else {
                ZStack {
                    if contactsState.addMenuePressed {
                        ContactAddView()
                            .zIndex(1)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    }
                    if contactsState.advancedMenuePressed {
                        CommandLineView()
                            .zIndex(1)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    }
                    AppView()
                        .zIndex(0)
                }.edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#if DEBUG
struct AppWrapper_Previews : PreviewProvider {
    init() {
        CoreDataManager.shared.changeToDevelopmentMode()
    }
    @ObservedObject static var authSate = AuthState()
    @ObservedObject static var contactsState = ContactsState()
    static var previews: some View {
        AppWrapper().environmentObject(authSate).environmentObject(contactsState)
    }
}
#endif
