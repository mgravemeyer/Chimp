import SwiftUI

struct ProjectAddView: View {
    
    @EnvironmentObject var projectsState: ProjectsState
    @EnvironmentObject var authState: AuthState
    
    let gray = Color(red: 207/255, green: 207/255, blue: 212/255)
    let lightGray = Color(red: 240/255, green: 240/255, blue: 240/255)
    
    @State var name = String()
    
    @State var selected = false
    @State var hoverRow = false
        
    var body: some View {
        GeometryReader { geometry in
            Group {
                HStack {
                    VStack {
                        RoundedRectangle(cornerRadius: 100).frame(width: 50, height: 50).padding(.bottom, 260)
                    }.frame(width: geometry.size.width/2, height: geometry.size.height)
                    VStack {
                        HStack {
                            Spacer()
                            Button("Close") {
                                projectsState.addMenuePressed.toggle()
                            }.padding(.trailing, 20).padding(.top, 30)
                        }
                        Spacer()
                        VStack {
                            HStack {
                                Text("Add").font(.system(size: 30)).fontWeight(.bold).zIndex(1)
                                Text("Project").font(.system(size: 30)).fontWeight(.light).zIndex(1)
                            }
                                ChimpTextField(placeholder: "Project Name", value: self.$name)
                           
                            ZStack(alignment: .center) {
                                HStack {
                                        Image(systemName: "square.and.arrow.down")
                                        Text("Save").fontWeight(.bold)
                                }.zIndex(1)
                                RoundedRectangle(cornerRadius: 20).foregroundColor(selected || hoverRow ? gray : lightGray).onHover { (hover) in
                                    self.hoverRow = hover
                                }
                            }.onTapGesture {
                                // TODO: save new contact function to the DB
                                self.projectsState.createProject(project: Project(name: self.name, start: "10.10.2010", end: "11.10.2010", clients: [], progress: 0, notes: "Notes"))
                                projectsState.addMenuePressed.toggle()
                            }
                        }.frame(maxWidth: 320, maxHeight: 320)
                        Spacer()
                    }.padding(.bottom, 50).zIndex(1).frame(width: geometry.size.width/2, height: geometry.size.height)
                }.background(Color.white).opacity(0.97)
            }
        }
    }
}
struct ProjectsAddView_Previews : PreviewProvider {
    static var previews: some View {
        CoreDataService.shared.changeToDevelopmentMode()
        return VStack {
            ProjectAddView()
                .frame(width: 500, height: 400)
                .frame(width: 500, height: 400)
        }.environmentObject(ContactsState())
    }
}
