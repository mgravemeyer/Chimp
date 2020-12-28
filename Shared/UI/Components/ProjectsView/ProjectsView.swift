import SwiftUI

struct ProjectsView: View {
    
    @EnvironmentObject var contactsState: ContactsState
    
    var body: some View {
        HStack {
            ProjectListView()
            ProjectDetailView()
        }
    }
}

#if DEBUG
struct ProjectsView_Previews : PreviewProvider {
    static var previews: some View {
        CoreDataService.shared.changeToDevelopmentMode()
        return ProjectsView()
        .environmentObject(AuthState())
        .environmentObject(ContactsState())
    }
}
#endif
