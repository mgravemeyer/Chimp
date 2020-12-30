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
            projectsState.addProject(name: "First Project", progress: 0)
            projectsState.addProject(name: "Second Project", progress: 30)
            projectsState.addProject(name: "Third Project", progress: 100)
            projectsState.addProject(name: "Third Project", progress: 120)
            return projectsState
        }())
        .environmentObject({ () -> ContactsState in
            let contactsState = ContactsState()
                contactsState.createContact(contact: Contact(firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "tLongFirstName", lastname: "tLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
                contactsState.createContact(contact: Contact(firstname: "TLongFirstName", lastname: "TLongLastName", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            return contactsState
        }())
    }
}
#endif
