import SwiftUI

@main
struct ChimpApp: App {
    
    @StateObject var authState = AuthState()
    @StateObject var projectsState = ProjectsState()
    @StateObject var contactsState = ContactsState()
    @StateObject var companiesState = CompaniesState()
    
    var body: some Scene {
            WindowGroup {
                AppWrapper()
                    .environment(\.managedObjectContext, CoreDataService.shared.viewContext)
                    .environmentObject(authState)
                    .environmentObject(projectsState)
                    .environmentObject(contactsState)
                    .environmentObject(companiesState)
            }.windowStyle(HiddenTitleBarWindowStyle())
    }
}
