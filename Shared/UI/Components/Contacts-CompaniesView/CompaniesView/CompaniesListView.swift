import SwiftUI

struct CompaniesListView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var companiesState: CompaniesState
    
    var body: some View {
        VStack {
            ListToolbar()
            ZStack {
                VStack {
                    HStack {
                        Text("Your").font(.system(size: 30)).fontWeight(.bold).zIndex(1)
                        Text("Companies").font(.system(size: 30)).fontWeight(.light).zIndex(1)
                        Spacer()
                    }
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(companiesState.getCompaniesCategories(), id: \.self) { categorie in
                            ContactVerticalListView(categorie: categorie)
                        }
                    }
                }.zIndex(1)
                Rectangle().foregroundColor(colorScheme == .dark ? Color.chimpDarkBackground : Color.chimpLightBackground)
            }
        }.frame(width: 230).padding(.top, 20).padding(.trailing, 20).padding(.top, 20)
    }
}
