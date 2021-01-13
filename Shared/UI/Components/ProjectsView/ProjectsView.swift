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
            projectsState.createProject(project: Project(name: "First Project", start: "20.10.2020", end: "25.10.2020", clients: [], progress: 10, notes: "Some Notes"))
            projectsState.createProject(project: Project(name: "Second Project", start: "20.10.2020", end: "25.10.2020", clients: [], progress: 40, notes: "Some Notes"))
            projectsState.createProject(project: Project(name: "First Project", start: "20.10.2020", end: "25.10.2020", clients: [], progress: 100, notes: "Third Notes"))
            return projectsState
        }())
        .environmentObject({ () -> ContactsState in
            let contactsState = ContactsState()
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "tLongFirstName", lastname: "tLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            contactsState.createContact(contact: Contact(id: UUID().uuidString, firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            return contactsState
        }())
    }
}
#endif
