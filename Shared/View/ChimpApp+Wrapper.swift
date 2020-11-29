//
//  ChimpApp.swift
//  Shared
//
//  Created by Maximilian Gravemeyer on 25.08.20.
//

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
    
    //Core data result for AuthDetail
    @FetchRequest(sortDescriptors: [])
    private var authDetail: FetchedResults<AuthDetail>

    @EnvironmentObject var contactsState: ContactsState
    
    @EnvironmentObject var authState: AuthState 
    
    var body: some View{
        if authState.authLoading{
            // on initial launch this will always get fired
            LoadingView().onAppear{
                self.authState.checkAuth(authDetail: authDetail)
            }
        }else{
            if !authState.loggedIn {
                LoginView()
            } else {
                ZStack {
                    if contactsState.addMenuePressed {
                        ContactAddView().zIndex(1)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    }
                    if contactsState.advancedMenuePressed {
                        CommandLineView().zIndex(1)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    }
                    AppView()
                        .zIndex(0)
                }.edgesIgnoringSafeArea(.all)
            }
        }
    }
}



extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
