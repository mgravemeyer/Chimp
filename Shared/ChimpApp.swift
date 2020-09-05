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
    var body: some Scene {
            WindowGroup {
                if userState.loggedIn {
                    LoginView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .environmentObject(userState)
                        .environmentObject(contactsState)
                } else {
                    ZStack {
                        if contactsState.addMenuePressed {
                            ContactAddView().zIndex(1)
                                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                                .environmentObject(userState)
                                .environmentObject(contactsState)
                        }
                        AppView()
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
    let gray = Color(red: 207/255, green: 207/255, blue: 212/255)
    let lightGray = Color(red: 240/255, green: 240/255, blue: 240/255)
    @State var firstname = String()
    @State var lastname = String()
    @State var email = String()
    @State var telephone = String()
    @State var birthday = String()
    @State var company = String()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        // TODO: make view over window toolbar items, close but should overlay the toolbar items
                        Button("Close") {
                            contactsState.addMenuePressed.toggle()
                        }.padding(.trailing, 20).padding(.top, 20)
                    }
                    Spacer()
                    VStack {
                        Text("Add a new Contact").font(.title)
                        HStack {
                            TextField("First Name", text: self.$firstname)
                            TextField("Last Name", text: self.$lastname)
                        }
                        TextField("E-Mail", text: self.$email)
                        TextField("Telephone", text: self.$telephone)
                        TextField("Birthday", text: self.$birthday)
                        Button {
                            // TODO: save new contact function
                            self.contactsState.addContact(firstname: self.firstname, lastname: self.lastname, email: self.email, telephone: self.telephone, birthday: self.birthday, company: self.company)
                            contactsState.addMenuePressed.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                Text("Save")
                            }.frame(width: 290)
                        }.padding(.top, 10)
                    }.frame(maxWidth: 320, maxHeight: 320)
                    Spacer()
                }.padding(.bottom, 50).zIndex(1).frame(width: geometry.size.width, height: geometry.size.height).background(Color.white).opacity(0.94)
            }
        }
    }
}
