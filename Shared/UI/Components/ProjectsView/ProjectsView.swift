import SwiftUI

struct ProjectsView: View {
    
    @EnvironmentObject var contactsState: ContactsState
    
    var body: some View {
        HStack {
            ProjectListView()
        }
    }
}
