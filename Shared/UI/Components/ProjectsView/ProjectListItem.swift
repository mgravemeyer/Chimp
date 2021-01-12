import SwiftUI

struct ProjectListItem: View {
    
    let lightGray = Color(red: 240/255, green: 240/255, blue: 240/255)
    @EnvironmentObject var projectsState: ProjectsState
    var project: Project
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(project.name)
                    Spacer()
                    ZStack {
                        Text("20").zIndex(1).foregroundColor(Color.white)
                        Circle().frame(width: 20,height: 20).foregroundColor(Color.blue)
                    }
                }
                VStack {
                    HStack {
                        Text("\(project.progress) %")
                        Spacer()
                    }
                    RoundedRectangle(cornerRadius: 3).frame(height: 4)
                }
            }.zIndex(1).padding(.horizontal, 10)
            RoundedRectangle(cornerRadius: 10).foregroundColor(lightGray)
        }.frame(height: 60).onTapGesture {
            projectsState.selectProject(project: project.id)
        }
    }
}
