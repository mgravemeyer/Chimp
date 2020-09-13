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
                        Button("") {
                            contactsState.advancedMenuePressed.toggle()
                        }.keyboardShortcut("j", modifiers: .command).zIndex(-10000)
                        
                        if contactsState.addMenuePressed {
                            ContactAddView().zIndex(1)
                                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                                .environmentObject(userState)
                                .environmentObject(contactsState)
                        }
                        if contactsState.advancedMenuePressed {
                            AdvancedMenue().zIndex(1)
                                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                                .environmentObject(userState)
                                .environmentObject(contactsState)
                        }
                        AppView()
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                            .environmentObject(userState)
                            .environmentObject(contactsState)
                            .zIndex(0)
                    }.edgesIgnoringSafeArea(.all)
                }
            }.windowStyle(HiddenTitleBarWindowStyle())
    }
}
    
    
struct AdvancedMenue: View {
    @EnvironmentObject var contactsState: ContactsState
    @State var advancedCommand = String()
    @State var boxHeight = CGFloat(50)
    @State var isSelected = false
    @State var geoBox = CGFloat()
    var body: some View {
        
        let binding = Binding<String>(get: {
                    self.advancedCommand
            }, set: {
                    self.advancedCommand = $0
                self.boxHeight = CGFloat(50 + contactsState.getContactsBySearch(search: advancedCommand).count * 55)
            })
        
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        // TODO: make view over window toolbar items, close but should overlay the toolbar items
                        Button("Close") {
                            contactsState.advancedMenuePressed.toggle()
                        }.padding(.trailing, 20).padding(.top, 30)
                    }
                    Spacer()
                    ZStack {
                        GeometryReader { geometryBox in
                            RoundedRectangle(cornerRadius: 15).foregroundColor(Color(red: 250/255, green: 250/255, blue: 250/255))
                        
                        VStack {
                            ZStack {
                                HStack {
                                    if advancedCommand.first == "/" {
                                        Image(systemName: "command").transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.08))).font(.system(size: 18, weight: .medium)).padding(.leading, 18)
                                    } else {
                                        Image(systemName: "magnifyingglass").transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.08))).font(.system(size: 18, weight: .medium)).padding(.leading, 18)
                                    }
                                    TextField("Enter for search or use / for a command", text: binding).font(.system(size: 18, weight: .medium)).frame(height: 50).font(.title).textFieldStyle(PlainTextFieldStyle()).padding(.trailing, 10)
                                }
                            }
                            Group {
                                ForEach(contactsState.getContactsBySearch(search: advancedCommand), id: \.self) { contact in
                                    AdvancedMenuRow(contact: contact, isHovered: false).padding(.leading, 10).padding(.trailing, 10).padding(.top, -5).padding(.bottom, -5)
                                }
                            }
                        }
                        }
                    }.frame(width: 450, height: self.boxHeight).padding(.bottom, geoBox)
                    Spacer()
                }.zIndex(1).frame(width: geometry.size.width, height: geometry.size.height).background(Color.white).opacity(0.97)
            }
        }
    }
}

struct AdvancedMenuRow: View {
    @State var contact: Contact
    @State var isHovered : Bool
    
    var body: some View {
        HStack {
            Text(contact.firstname).font(.system(size: 18, weight: .medium))
            Text(contact.lastname).font(.system(size: 18, weight: .medium))
            Spacer()
            if isHovered {
                Text("Use with").font(.system(size: 14, weight: .medium))
                Image(systemName: "return").font(.system(size: 14, weight: .medium))
                Text("or").font(.system(size: 14, weight: .medium))
                Image(systemName: "cursorarrow.rays").font(.system(size: 14, weight: .medium))
            }
            //This Line Is A Fix For Weird Padding Behavior in SwiftUI
            Image(systemName: "cursorarrow.rays").font(.system(size: 14, weight: .medium)).opacity(0).padding(.trailing, -15)
        }.padding(.top, 0).padding(.bottom, 0).frame(height: 50).font(.system(size: 18, weight: .medium)).font(.title).padding(.leading, 5).padding(.trailing, 5).background(isHovered ? Color(red: 240/255, green: 240/255, blue: 240/255) : Color.red.opacity(0)).cornerRadius(10).onHover { (isHovered) in
            self.isHovered = isHovered
        }
    }
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
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
                        }.padding(.trailing, 20).padding(.top, 30)
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
                }.padding(.bottom, 50).zIndex(1).frame(width: geometry.size.width, height: geometry.size.height).background(Color.white).opacity(0.97)
            }
        }
    }
}
