import SwiftUI

struct ProjectDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var projectsState: ProjectsState
    @State var selection = "Calls"
    var project: Project
    
        var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                HStack {
                    Text(project.name).font(.system(size: 30)).fontWeight(.light).lineLimit(1)
                    Spacer()
                    Button("Add Project") {
                        projectsState.addMenuePressed.toggle()
                    }
                }.padding(.bottom, 20)
//                ContactsDetailContactRow(selectedContact: contact)
//                    .buttonStyle(PlainButtonStyle())
//                    .padding(.bottom, 10)
//                    ContactsDetailTagRow(selectedContact: contact).padding(.bottom, 12)
                HStack {
                    Spacer()
                    VStack {
                        ContactsDetailRadioSection(selection: $selection)
                        ContactsDetailRadioList(selection: $selection)
                    }
                    Spacer()
                }
                Spacer()
            }.zIndex(1)
            Rectangle().foregroundColor(colorScheme == .dark ? Color.chimpDarkBackground : Color.chimpLightBackground).zIndex(0)
        }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 40)
    }
}
