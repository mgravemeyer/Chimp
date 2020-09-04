//
//  ChimpApp.swift
//  Shared
//
//  Created by Maximilian Gravemeyer on 25.08.20.
//

import SwiftUI

@main
struct ChimpApp: App {    
    @StateObject var contactsState = ContactsState()
    @StateObject var userState = UserState()
    let persistenceController = PersistenceController.shared
    @State var contactAddViewShown = false
    var body: some Scene {
            WindowGroup {
                if userState.loggedIn {
                    LoginView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .environmentObject(userState)
                        .environmentObject(contactsState)
                } else {
                    ZStack {
                        if contactAddViewShown {
                            ContactAddView(contactAddViewShown: self.$contactAddViewShown).zIndex(1)
                                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                                .environmentObject(userState)
                                .environmentObject(contactsState)
                        }
                        AppView(contactAddViewShown: self.$contactAddViewShown)
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                            .environmentObject(userState)
                            .environmentObject(contactsState)
                            .zIndex(0)
                    }
                }
            }
    }
}

struct ContactAddView: View {
    @EnvironmentObject var contactsState: ContactsState
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
                            self.contactsState.addContact(firstname: self.name, lastname: self.name)
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
