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
    
    @Binding var contactAddViewShown: Bool
    var body: some View {
        ZStack {
            Color.white
            HStack {
                MenueSidebarList()
                VStack {
                    ContactsView()
                }
            }
        }.frame(minWidth: 600, minHeight: 400)
    }
    
    func toggleSidebar() {
            NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }

    func addContact() {
        contactAddViewShown.toggle()
        print("Added Contact")
    }
    
}

struct MenueSidebarList: View {
    
    var body: some View {
        ScrollView {
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
                    CategoryRow(category: Category(selected: false, symbol: "🗓", name: "This Week", notification: 0))
                    CategoryRow(category: Category(selected: false, symbol: "🛠", name: "Projects", notification: 0))
                    CategoryRow(category: Category(selected: true, symbol: "🙋‍♂️", name: "Contacts", notification: 0))
                    CategoryRow(category: Category(selected: false, symbol: "📝", name: "Tasks", notification: 0))
                    CategoryRow(category: Category(selected: false, symbol: "📄", name: "Files", notification: 0))
                    CategoryRow(category: Category(selected: false, symbol: "✉️", name: "E-Mails", notification: 0))
                }.padding(.top, 20)
                
            }
        }.padding(30)
        
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
    var body: some View {
        HStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        Text("Your").font(.system(size: 30)).fontWeight(.bold).zIndex(1)
                        Text("Contacts").font(.system(size: 30)).fontWeight(.light).zIndex(1)
                        Spacer()
                    }
                    ContactsListLetterSection()
                }.zIndex(1)
                Rectangle().foregroundColor(Color.white)
            }.frame(width: 230).padding(.bottom, 20).padding(.top, 5).padding(.trailing, 20).padding(.top, 20)
            ZStack() {
                Image("Contacts_Detail").resizable().frame(width: 300, height: 300).zIndex(1)
                Rectangle().foregroundColor(Color.white)
            }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 20)
        }
    }
}

struct ContactsListLetterSection: View {
    var body: some View {
        HStack(alignment: .top) {
            Text("M").font(.system(size: 30)).fontWeight(.bold).padding(.trailing, 10)
            VStack {
                ContactListItem(contact: Contact(firstname: "Max", lastname: "Muster")).padding(.bottom, 8)
            }
            Spacer()
        }.padding(.top, 20)
    }
}

struct ContactListItem: View {
    @State var contact: Contact
    var body: some View {
        VStack {
            HStack {
                Text("\(contact.firstname)").padding(.trailing, -5)
                Text("\(contact.lastname)").fontWeight(.bold)
            }
        }
    }
}
