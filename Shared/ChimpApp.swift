//
//  ChimpApp.swift
//  Shared
//
//  Created by Maximilian Gravemeyer on 25.08.20.
//

import SwiftUI

@main
struct ChimpApp: App {
    @StateObject var appState = AppState()
    let persistenceController = PersistenceController.shared
    @State var loggedIn = false
    @State var contactAddViewShown = false
    var body: some Scene {
            WindowGroup {
                if loggedIn {
                    LoginView(loggedIn: self.$loggedIn).environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(appState)
                } else {
                    ZStack {
                        if contactAddViewShown {
                            ContactAddView(contactAddViewShown: self.$contactAddViewShown).zIndex(1).environmentObject(appState)
                        }
                        AppView(contactAddViewShown: self.$contactAddViewShown).zIndex(0).environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(appState)
                    }
                }
            }
    }
}

struct ContactAddView: View {
    @EnvironmentObject var appState: AppState
    @State var name = String()
    @Binding var contactAddViewShown: Bool
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        // TODO: make view over window toolbar items, close but should overlay the toolbar items
                        Button("Close") {
                            contactAddViewShown.toggle()
                        }.padding(.trailing, 20).padding(.top, 20)
                    }
                    Spacer()
                    VStack {
                        Text("Add a new Contact").font(.title)
                        TextField("Name", text: self.$name)
                        Button {
                            // TODO: save new contact function
                            appState.contactsState.addContact(name: self.name)
                            contactAddViewShown.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                Text("Save")
                            }.frame(width: 290)
                        }.padding(.top, 10)
                    }.frame(maxWidth: 320, maxHeight: 320)
                    Spacer()
                }.zIndex(1).frame(width: geometry.size.width, height: geometry.size.height).background(Color(red: 50/255, green: 51/255, blue: 51/255)).opacity(0.96)
            }
        }
    }
}
