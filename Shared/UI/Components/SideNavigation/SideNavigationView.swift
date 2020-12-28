import SwiftUI

struct SideNavigationView: View {
    
    @EnvironmentObject var authState: AuthState
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var authDetail: FetchedResults<AuthDetail>
    
    @Binding var selection: String
    
    let categories = [
//        NavigationCategory(symbol: "☀️", name: "Today", notification: 32),
//        NavigationCategory(symbol: "🗓", name: "This Week", notification: 78),
        NavigationCategory(symbol: "🛠", name: "Projects", notification: 0),
        NavigationCategory(symbol: "🙋‍♂️", name: "Contacts", notification: 0),
//        NavigationCategory(symbol: "📝", name: "Tasks", notification: 0),
//        NavigationCategory(symbol: "🏷", name: "Tags", notification: 0),
//        NavigationCategory(symbol: "📄", name: "Files", notification: 0),
//        NavigationCategory(symbol: "✉️", name: "E-Mails", notification: 0),
//        NavigationCategory(symbol: "⚙️", name: "Settings", notification: 0)
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
                        if categorie.id.uuidString == selection {
                            SideNavigationRow(selected: self.$selection, selectedBool: true, category: categorie)
                        } else {
                            SideNavigationRow(selected: self.$selection, selectedBool: false, category: categorie)
                        }
                    }
                }.padding(.top, 20)
                Button {
                    self.authState.deauthUser(authDetail: authDetail, viewContext: viewContext)
//                    self.authState.deleteAuthDetail(authDetail: authDetail, viewContext: viewContext)
                    
                } label: {
                    Text("Log out")
                        .fontWeight(.semibold)
                        .frame(minWidth: 160)
                        .foregroundColor(Color.black)
                }
            }.padding(20).padding(.top, 20)
        }
    }
}

//struct SideNavigationView_Previews : PreviewProvider {
//    @State var selection: "Contacts"
//    static var previews: some View {
//        CoreDataService.shared.changeToDevelopmentMode()
//        return VStack {
//            SideNavigationView(selection: selection)
//        }.environmentObject(ContactsState())
//    }
//}
