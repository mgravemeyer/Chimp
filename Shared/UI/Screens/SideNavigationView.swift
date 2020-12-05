import SwiftUI

struct SideNavigationView: View {
    
    //Core data result for AuthDetail
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var authDetail: FetchedResults<AuthDetail>
    
    @State var selectedMenue = ""
    @EnvironmentObject var authState: AuthState

    let categories = [
        NavigationCategory(symbol: "☀️", name: "Today", notification: 32),
        NavigationCategory(symbol: "🗓", name: "This Week", notification: 78),
        NavigationCategory(symbol: "🛠", name: "Projects", notification: 0),
        NavigationCategory(symbol: "🙋‍♂️", name: "Contacts", notification: 0),
        NavigationCategory(symbol: "📝", name: "Tasks", notification: 0),
        NavigationCategory(symbol: "🏷", name: "Tags", notification: 0),
        NavigationCategory(symbol: "📄", name: "Files", notification: 0),
        NavigationCategory(symbol: "✉️", name: "E-Mails", notification: 0),
        NavigationCategory(symbol: "⚙️", name: "Settings", notification: 0)
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
                            SideNavigationRow(selected: self.$selectedMenue, selectedBool: true, category: categorie)
                        } else {
                            SideNavigationRow(selected: self.$selectedMenue, selectedBool: false, category: categorie)
                        }
                    }
                }.padding(.top, 20)
                Button {
                    self.authState.deauthUser(authDetail: authDetail, viewContext: viewContext)
//                    self.authState.deleteAuthDetail(authDetail: authDetail, viewContext: viewContext)
                    
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

struct SideNavigationRow: View {
    @Binding var selected: String
    @State var selectedBool: Bool
    @State var category: NavigationCategory
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
