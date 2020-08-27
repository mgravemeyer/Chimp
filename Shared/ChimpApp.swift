//
//  ChimpApp.swift
//  Shared
//
//  Created by Maximilian Gravemeyer on 25.08.20.
//

import SwiftUI

@main
struct ChimpApp: App {
    let persistenceController = PersistenceController.shared
    @State var loggedIn = false
    var body: some Scene {
            WindowGroup {
                if !loggedIn {
                    LoginView(loggedIn: self.$loggedIn).environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else {
                    AppView().environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
    }
}
