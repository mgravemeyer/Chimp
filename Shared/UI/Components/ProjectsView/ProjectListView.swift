import SwiftUI

struct ProjectListView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var projectsState: ProjectsState
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Your").font(.system(size: 30)).fontWeight(.bold).zIndex(1)
                    Text("Projects").font(.system(size: 30)).fontWeight(.light).zIndex(1)
                    Spacer()
                }
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(projectsState.projects, id: \.self) { project in
                        ProjectListItem(project: project).padding(.bottom, 8)
                    }
                }
            }.zIndex(1)
            Rectangle().foregroundColor(colorScheme == .dark ? Color.chimpDarkBackground : Color.chimpLightBackground)
        }.frame(width: 230).padding(.top, 20).padding(.trailing, 20).padding(.top, 20)
    }
}
