//
//  ChimpAppView.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 27.08.20.
//

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    var selected: Bool
    let symbol: String
    let name: String
    var notification: Int
}

struct AppView: View {
    @EnvironmentObject var contactsState: ContactsState
    var body: some View {
        ZStack {
            Color.white
            HStack {
                MenueSidebarList()
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
                    CategoryRow(category: Category(selected: false, symbol: "☀️", name: "Today", notification: 32))
                    CategoryRow(category: Category(selected: false, symbol: "🗓", name: "This Week", notification: 78))
                    CategoryRow(category: Category(selected: false, symbol: "🛠", name: "Projects", notification: 0))
                    CategoryRow(category: Category(selected: true, symbol: "🙋‍♂️", name: "Contacts", notification: 0))
                    CategoryRow(category: Category(selected: false, symbol: "📝", name: "Tasks", notification: 0))
                    CategoryRow(category: Category(selected: false, symbol: "📄", name: "Files", notification: 0))
                    CategoryRow(category: Category(selected: false, symbol: "✉️", name: "E-Mails", notification: 0))
                    CategoryRow(category: Category(selected: false, symbol: "⚙️", name: "Settings", notification: 0))
                }.padding(.top, 20)
            }.padding(30)
        }
        
    }
}

struct CategoryRow: View {
    
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
            RoundedRectangle(cornerRadius: 10).foregroundColor(category.selected || hoverRow ? lightGray : Color.white).onHover { (hover) in
                self.hoverRow = hover
            }.onTapGesture {
                self.category.selected.toggle()
            }
        }.frame(width: 180, height: 37)
    }
}

class WindowController: NSWindowController {
  
  override func windowDidLoad() {
    super.windowDidLoad()
    window?.titlebarAppearsTransparent = true
  }
    
}

struct ContactsView: View {
    
    @EnvironmentObject var contactsState: ContactsState
    
    var body: some View {
        HStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        Text("Your").font(.system(size: 30)).fontWeight(.bold).zIndex(1)
                        Text("Contacts").font(.system(size: 30)).fontWeight(.light).zIndex(1)
                        Spacer()
                    }
                    ForEach(contactsState.getContactCategories(), id: \.self) { categorie in
                        ContactsListSection(categorie: categorie)
                    }
                }.zIndex(1)
                Rectangle().foregroundColor(Color.white)
            }.frame(width: 230).padding(.bottom, 20).padding(.top, 5).padding(.trailing, 20).padding(.top, 20)
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
                }.padding(.bottom, 20)
                    ContactsDetailContactRow().padding(.bottom, 5)
                    ContactsDetailInformation().padding(.bottom, 5)
                    ContactsDetailTagRow().padding(.bottom, 5)
                Spacer()
            }.zIndex(1)
            Rectangle().foregroundColor(Color.white).zIndex(0)
        }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 25)
    }
}

struct ContactsDetailContactRow: View {
    var body: some View {
        HStack {
            Text("✉️ m.gravemeyer@icloud.com")
            Text("📞📝 0162/4375779")
        }
    }
}

struct ContactsDetailInformation: View {
    var body: some View {
        HStack {
            Text("🎂 17.01.1998")
            Text("🏢 Chimp UG")
        }
    }
}

struct ContactsDetailTagRow: View {
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
                        ContactListItem(contact: contact).padding(.bottom, 8)
                    }
                }
            }
            Spacer()
        }.padding(.top, 20)
    }
}

struct ContactListItem: View {
    @EnvironmentObject var contactsState: ContactsState
    @State var contact: Contact
    var body: some View {
        VStack {
            HStack {
                Text("\(contact.firstname)").padding(.trailing, -5)
                Text("\(contact.lastname)").fontWeight(.bold)
            }
        }.onTapGesture {
            contactsState.selectedContact  = contact.id.uuidString
        }
    }
}
