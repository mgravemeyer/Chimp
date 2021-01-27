import SwiftUI

struct ProjectsView: View {
    
    @EnvironmentObject var projectsState: ProjectsState
    
    var body: some View {
        HStack {
            ProjectListView()
            if projectsState.selectedProject == "" {
                EmptyProjectDetail()
            } else {
                ProjectDetailView(project: projectsState.getSelectedProject())
            }
        }
    }
}

#if DEBUG
struct ProjectsView_Previews : PreviewProvider {
    static var previews: some View {
        CoreDataService.shared.changeToDevelopmentMode()
        return ProjectsView()
        .environmentObject(AuthState())
        .environmentObject({ () -> ProjectsState in
            let projectsState = ProjectsState()
           
            projectsState.createProject(project: Project(id: UUID().uuidString,name: "First Project", start: "20.10.2020", end: "25.10.2020", clients: [], progress: 10, notes: "Some Notes", status: "Some Status", tag_uids: [], due: "0"))
            projectsState.createProject(project: Project(id: UUID().uuidString, name: "Second Project", start: "20.10.2020", end: "25.10.2020", clients: [], progress: 40, notes: "Some Notes",status: "Some Status", tag_uids: [], due: "0" ))
            projectsState.createProject(project: Project(id: UUID().uuidString, name: "First Project", start: "20.10.2020", end: "25.10.2020", clients: [], progress: 100, notes: "Third Notes", status: "Some Status", tag_uids: [], due: "0"))
            return projectsState
        }())
        .environmentObject({ () -> ContactsState in
            let contactsState = ContactsState()
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: []))
  
            return contactsState
        }())
    }
}
#endif
