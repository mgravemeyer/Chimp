import SwiftUI

struct ContactListView: View {
    
    @EnvironmentObject var contactsState: ContactsState
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Your").font(.system(size: 30)).fontWeight(.bold).zIndex(1)
                    Text("Contacts").font(.system(size: 30)).fontWeight(.light).zIndex(1)
                    Spacer()
                }
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(contactsState.getContactCategories(), id: \.self) { categorie in
                        ContactVerticalListView(categorie: categorie)
                    }
                }
            }.zIndex(1)
            Rectangle().foregroundColor(Color.white)
        }.frame(width: 230).padding(.top, 20).padding(.trailing, 20).padding(.top, 20)
    }
}
