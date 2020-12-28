import SwiftUI

struct ProjectListItem: View {
    var project: Project
    var body: some View {
        VStack {
            Text(project.name)
        }
    }
}
