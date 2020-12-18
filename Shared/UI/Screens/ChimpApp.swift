import SwiftUI

@main
struct ChimpApp: App {
    
    @StateObject var authState = AuthState()
    @StateObject var contactsState = ContactsState()
    
    var body: some Scene {
            WindowGroup {
                AppWrapper()
                    .environment(\.managedObjectContext, CoreDataService.shared.viewContext)
                    .environmentObject(authState)
                    .environmentObject(contactsState)
            }.windowStyle(HiddenTitleBarWindowStyle())
    }
}