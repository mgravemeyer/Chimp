import SwiftUI

struct AppWrapper: View {
    
    @EnvironmentObject var authState: AuthState
    @EnvironmentObject var contactsState: ContactsState
    
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
                    AppView()
                        .zIndex(0)
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
            AppWrapper()
                .environmentObject({ () -> AuthState in
                    let authState = AuthState()
                    authState.loggedIn = true
                    return authState
                }())
                .environmentObject(ContactsState())
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
            AppWrapper()
                .environmentObject({ () -> AuthState in
                    let authState = AuthState()
                    authState.loggedIn = false
                    return authState
                }())
                .environmentObject({ () -> ContactsState in
                    let contactsState = ContactsState()
                    contactsState.advancedMenuePressed = true
                    return contactsState
                }())
            AppWrapper()
                .environmentObject({ () -> AuthState in
                    let authState = AuthState()
                    authState.loggedIn = true
                    return authState
                }())
                .environmentObject({ () -> ContactsState in
                    let contactsState = ContactsState()
                    contactsState.advancedMenuePressed = true
                    contactsState.addMenuePressed = true
                    return contactsState
                }())
        }
    }
}
#endif
