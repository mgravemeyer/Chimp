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
    static var previews: some View {
        CoreDataManager.shared.changeToDevelopmentMode()
        return VStack {
            AppWrapper()
                .environmentObject(AuthState())
                .environmentObject(ContactsState())
                .environment(\.colorScheme, .light)
            AppWrapper()
                .environmentObject({ () -> AuthState in
                    let authState = AuthState()
                    authState.loggedIn = true
                    return authState
                }())
                .environmentObject({ () -> ContactsState in
                    let contactsState = ContactsState()
                    contactsState.advancedMenuePressed = true
                    return contactsState
                }())
                .environment(\.colorScheme, .light)
            AppWrapper()
                .environmentObject({ () -> AuthState in
                    let authState = AuthState()
                    authState.loggedIn = true
                    return authState
                }())
                .environmentObject({ () -> ContactsState in
                    let contactsState = ContactsState()
                    contactsState.addMenuePressed = true
                    return contactsState
                }())
                .environment(\.colorScheme, .light)
                AppWrapper()
                    .environmentObject(AuthState())
                    .environmentObject(ContactsState())
                    .environment(\.colorScheme, .dark)
                AppWrapper()
                    .environmentObject({ () -> AuthState in
                        let authState = AuthState()
                        authState.loggedIn = true
                        return authState
                    }())
                    .environmentObject({ () -> ContactsState in
                        let contactsState = ContactsState()
                        contactsState.advancedMenuePressed = true
                        return contactsState
                    }())
                    .environment(\.colorScheme, .dark)
                AppWrapper()
                    .environmentObject({ () -> AuthState in
                        let authState = AuthState()
                        authState.loggedIn = true
                        return authState
                    }())
                    .environmentObject({ () -> ContactsState in
                        let contactsState = ContactsState()
                        contactsState.addMenuePressed = true
                        return contactsState
                    }())
                    .environment(\.colorScheme, .dark)
        }
    }
}
#endif
