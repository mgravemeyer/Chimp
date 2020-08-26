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

    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            LoginView_iOS()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            #elseif os(macOS)
            LoginView_macOS()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            #endif
        }
    }
}
