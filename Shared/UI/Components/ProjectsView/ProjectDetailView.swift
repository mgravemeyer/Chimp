import SwiftUI

struct ProjectDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var projectsState: ProjectsState
    
        var body: some View {
        ZStack {
            Button(action: {
                projectsState.addMenuePressed.toggle()
            }, label: {
                Text("Project Details")
            }).zIndex(1)
            Rectangle().foregroundColor(colorScheme == .dark ? Color.chimpDarkBackground : Color.chimpLightBackground).zIndex(0)
        }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 40)
    }
}
