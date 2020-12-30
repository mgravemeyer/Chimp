import Foundation
import CoreData
import SwiftUI

class ProjectsState: ObservableObject {
    
    @Published var projects = [Project]()
    @Published var addMenuePressed = false
    @Published var selectedProject = ""
    
    func addProject(name: String, progress: Int) {
        projects.append(Project(name: name, progress: progress))
    }
    
    func selectContact(project: UUID) {
        selectedProject = project.uuidString
    }
    
    func getSelectedProject() -> Project {
        if let project = projects.first(where: {$0.id.uuidString == self.selectedProject}) {
            return project
        } else {
            /* to:do throw error message to frontend */
            return Project(name: "error", progress: 000)
        }
    }
}
