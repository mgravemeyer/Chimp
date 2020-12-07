import SwiftUI

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

#if DEBUG
struct SideNavigationRow_Previews : PreviewProvider {
    @State static var selected = String()
    static var previews: some View {
        VStack {
            SideNavigationRow(selected: $selected, selectedBool: false, category: NavigationCategory(symbol: "☀️", name: "Today", notification: 32))
            SideNavigationRow(selected: $selected, selectedBool: true, category: NavigationCategory(symbol: "🏃🏻‍♂️", name: "SometText", notification: 32))
            SideNavigationRow(selected: $selected, selectedBool: false, category: NavigationCategory(symbol: "Symbol", name: "TodayTextTooLongasdasd", notification: 32))
        }
    }
}
#endif
