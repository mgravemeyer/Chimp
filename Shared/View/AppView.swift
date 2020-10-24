//
//  ChimpAppView.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 27.08.20.
//

import SwiftUI

struct Category: Identifiable, Hashable {
    let id = UUID()
    let symbol: String
    let name: String
    var notification: Int
}

struct AppView: View {
    @EnvironmentObject var contactsState: ContactsState
    @EnvironmentObject var authState: AuthState
    var body: some View {
        ZStack {
            Color.white
            HStack {
                MenueSidebarList().environmentObject(authState)
                VStack {
                    ContactsView()
                }
            }
        }.frame(minWidth: 900, minHeight: 500)
    }
    
    func toggleSidebar() {
            NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }

    func addContact() {
        contactsState.addMenuePressed.toggle()
        print("Added Contact")
    }
    
}

struct MenueSidebarList: View {
    
    //Core data result for AuthDetail
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var authDetail: FetchedResults<AuthDetail>
    
    @State var selectedMenue = ""
    @EnvironmentObject var authState: AuthState
    
   


    let categories = [
        Category(symbol: "☀️", name: "Today", notification: 32),
        Category(symbol: "🗓", name: "This Week", notification: 78),
        Category(symbol: "🛠", name: "Projects", notification: 0),
        Category(symbol: "🙋‍♂️", name: "Contacts", notification: 0),
        Category(symbol: "📝", name: "Tasks", notification: 0),
        Category(symbol: "🏷", name: "Tags", notification: 0),
        Category(symbol: "📄", name: "Files", notification: 0),
        Category(symbol: "✉️", name: "E-Mails", notification: 0),
        Category(symbol: "⚙️", name: "Settings", notification: 0)
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    Image("Profile_Picture").resizable().frame(width: 45, height: 45).cornerRadius(15)
                    VStack(alignment: .leading) {
                        Text("Good morning, Sean").font(.headline).foregroundColor(Color.black).fontWeight(.semibold)
                        Text("18°C in Berlin").foregroundColor(Color(red: 177/255, green: 177/255, blue: 182/255))
                    }
                }
//                Text("Overview").font(.headline).foregroundColor(Color(red: 177/255, green: 177/255, blue: 182/255)).fontWeight(.semibold).padding(.top, 10)
                VStack {
                    ForEach(categories, id: \.self) { categorie in
                        if categorie.id.uuidString == selectedMenue {
                            CategoryRow(selected: self.$selectedMenue, selectedBool: true, category: categorie)
                        } else {
                            CategoryRow(selected: self.$selectedMenue, selectedBool: false, category: categorie)
                        }
                    }
                }.padding(.top, 20)
                Button {
                    self.authState.deauthUser(authDetail: authDetail, viewContext: viewContext)
                    
                } label: {
                    Text("Log out")
                        .fontWeight(.semibold)
                        .frame(minWidth: 230)
                        .foregroundColor(Color.black)
                }
            }.padding(20).padding(.top, 20)
        }
    }
}

struct CategoryRow: View {
    @Binding var selected: String
    @State var selectedBool: Bool
    @State var category: Category
    @State private var hoverRow = false
    let gray = Color(red: 207/255, green: 207/255, blue: 212/255)
    let lightGray = Color(red: 240/255, green: 240/255, blue: 240/255)
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Text(category.symbol).padding(.leading, 10)
                Text(category.name).fontWeight(.semibold).foregroundColor(Color.black)
                Spacer()
                if category.notification > 0 {
                    ZStack {
                        Text("\(category.notification)").foregroundColor(Color.white).zIndex(1)
                        RoundedRectangle(cornerRadius: 6).frame(width: 20, height: 20).foregroundColor(Color(red: 207/255, green: 207/255, blue: 212/255)).padding(10).zIndex(0)
                    }
                }
            }.zIndex(1)
            RoundedRectangle(cornerRadius: 10).foregroundColor(selectedBool || hoverRow ? lightGray : Color.white).onHover { (hover) in
                self.hoverRow = hover
            }
        }.onTapGesture {
            self.selected = category.id.uuidString
        }.frame(width: 180, height: 37)
    }
}

func showWindow(contact: Contact) {
    let mousePos = NSEvent.mouseLocation
    var windowRef:NSWindow
    windowRef = NSWindow(
        contentRect: NSRect(x: mousePos.x, y: mousePos.y, width: 300, height: 400),
        styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView, .resizable],
        backing: .buffered, defer: false)
    windowRef.contentView = NSHostingView(rootView: MyView(contact: contact, myWindow: windowRef))
    windowRef.makeKeyAndOrderFront(nil)
}

struct MyView: View {
    let contact: Contact
    let myWindow:NSWindow?
    var body: some View {
        ContactsDetailsExtraWindow(contact: contact).edgesIgnoringSafeArea(.all).padding(.leading, 10)
    }
}

struct ContactsDetailsExtraWindow: View {
    
    @EnvironmentObject var contactsState: ContactsState
    var contact: Contact
    
    var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                HStack {
                    Text(contact.firstname).font(.system(size: 30)).fontWeight(.light)
                    Text(contact.lastname).font(.system(size: 30)).fontWeight(.bold)
                    Spacer()
                }.padding(.bottom, 20)
                    ContactsDetailContactRow(selectedContact: contact).padding(.bottom, 12)
                    ContactsDetailInformation(selectedContact: contact).padding(.bottom, 12)
                    ContactsDetailTagRow(selectedContact: contact).padding(.bottom, 12)
                Spacer()
            }.zIndex(1)
            Rectangle().foregroundColor(Color.white).zIndex(0)
        }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 40)
    }
}

struct ContactsView: View {
    
    @EnvironmentObject var contactsState: ContactsState
    let url = Bundle.main.url(forResource: "Images/grapes", withExtension: "png")
    var body: some View {
        HStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Your").font(.system(size: 30)).fontWeight(.bold).zIndex(1)
                        Text("Contacts").font(.system(size: 30)).fontWeight(.light).zIndex(1)
                        Spacer()
                    }
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(contactsState.getContactCategories(), id: \.self) { categorie in
                            ContactsListSection(categorie: categorie)
                        }
                    }
                }.zIndex(1)
                Rectangle().foregroundColor(Color.white)
            }.frame(width: 230).padding(.top, 20).padding(.trailing, 20).padding(.top, 20)
            if contactsState.selectedContact == "" {
                EmptyContactsDetail()
            } else {
                ContactsDetails(contact: contactsState.getSelectedContact())
            }
        }
    }
}

struct EmptyContactsDetail: View {
    
    @EnvironmentObject var contactsState: ContactsState
    
    var body: some View {
        ZStack() {
            Button {
                contactsState.addMenuePressed.toggle()
            } label: {
                Text("Add Contact")
            }.zIndex(2)
            Image("Contacts_Detail").resizable().frame(width: 300, height: 300).padding(.trailing, 40).zIndex(1)
            Rectangle().foregroundColor(Color.white)
        }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 20)
    }
}

struct ContactsDetails: View {
    
    @EnvironmentObject var contactsState: ContactsState
    var contact: Contact
    
    var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                HStack {
                    Text(contact.firstname).font(.system(size: 30)).fontWeight(.light)
                    Text(contact.lastname).font(.system(size: 30)).fontWeight(.bold)
                    Spacer()
                    Button("Add Contact") {
                        contactsState.addMenuePressed.toggle()
                    }
                }.padding(.bottom, 20)
                    ContactsDetailContactRow(selectedContact: contact).padding(.bottom, 12)
                    ContactsDetailInformation(selectedContact: contact).padding(.bottom, 12)
                    ContactsDetailTagRow(selectedContact: contact).padding(.bottom, 12)
                Spacer()
            }.zIndex(1)
            Rectangle().foregroundColor(Color.white).zIndex(0)
        }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 40)
    }
}

struct ContactsDetailContactRow: View {
    var selectedContact: Contact
    var body: some View {
        HStack {
            Button("✉️ \(selectedContact.email)") {
                NSWorkspace.shared.open(URL(string: "mailto:\(selectedContact.email)")!)
            }
            Button("📞 \(selectedContact.telephone)") {
                NSWorkspace.shared.open(URL(string: "tel://\(selectedContact.telephone)")!)
            }
        }
    }
}

struct ContactsDetailInformation: View {
    var selectedContact: Contact
    var body: some View {
        HStack {
            Text("🎂 \(selectedContact.birthday)")
            Text("🏢 \(selectedContact.company)")
        }
    }
}

struct ContactsDetailTagRow: View {
    var selectedContact: Contact
    var body: some View {
        HStack {
            TagView(tagText: "Tag One")
            TagView(tagText: "Tag Two")
        }
    }
}

struct TagView: View {
    @State var tagText: String
    var body: some View {
        Text(tagText)
            .frame(width: 100, height: 20)
            .foregroundColor(Color.white)
            .background(Color.orange)
            .cornerRadius(10)
    }
}

struct ContactsListSection: View {

    @EnvironmentObject var contactsState: ContactsState
    @State var categorie: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(self.categorie).font(.system(size: 30)).fontWeight(.bold).padding(.trailing, 10).frame(width: 40)
            VStack(alignment: .leading) {
                ForEach(contactsState.contacts, id: \.self) { contact in
                    if String(contact.lastname.first!) == categorie {
                        if contact.id.uuidString == contactsState.selectedContact {
                            ContactListItem(contact: contact, selected: true).padding(.bottom, 8)
                                .contextMenu {
                                    Button(action: {
                                        showWindow(contact: contact)
                                    }) {
                                        Text("Create New Window")
                                    }
                                    Button(action: {
                                        showWindow(contact: contact)
                                    }) {
                                        Text("Edit Contact")
                                    }
                                    Button(action: {
                                        showWindow(contact: contact)
                                    }) {
                                        Text("Delete Contact")
                                    }
                                }
                        } else {
                            ContactListItem(contact: contact, selected: false).padding(.bottom, 8)
                            .contextMenu {
                                Button(action: {
                                    showWindow(contact: contact)
                                }) {
                                    Text("Create New Window")
                                }
                                Button(action: {
                                    showWindow(contact: contact)
                                }) {
                                    Text("Edit Contact")
                                }
                                Button(action: {
                                    showWindow(contact: contact)
                                }) {
                                    Text("Delete Contact")
                                }
                            }
                        }
                    }
                }
            }
            Spacer()
        }.padding(.top, 20)
    }
}
//hoverRow ? lightGray : Color.white
struct ContactListItem: View {
    @EnvironmentObject var contactsState: ContactsState
    @State var contact: Contact
    @State var selected: Bool
    @State var hoverRow = false
    let gray = Color(red: 207/255, green: 207/255, blue: 212/255)
    let lightGray = Color(red: 240/255, green: 240/255, blue: 240/255)
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                    Text("\(contact.firstname)").padding(.trailing, -5).padding(.leading, 10)
                    Text("\(contact.lastname)").fontWeight(.bold)
                Spacer()
            }.zIndex(1)
            RoundedRectangle(cornerRadius: 10).foregroundColor(selected || hoverRow ? lightGray : Color.white).onHover { (hover) in
                self.hoverRow = hover
            }
        }.frame(width: 180, height: 37).padding(.bottom, -15).onTapGesture {
            contactsState.selectedContact  = contact.id.uuidString
        }
    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
