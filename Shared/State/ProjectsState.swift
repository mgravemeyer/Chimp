import Foundation
import CoreData
import SwiftUI

class ProjectsState: ObservableObject {
    
    @Published var projects = [Project]()
    @Published var addMenuePressed = false
    @Published var selectedProject = ""
    
    func addProject(project: Project) {
        projects.append(project)
    }
    
    func selectProject(project: UUID) {
        selectedProject = project.uuidString
    }
    
    func getSelectedProject() -> Project {
        if let project = projects.first(where: {$0.id.uuidString == self.selectedProject}) {
            return project
        } else {
            /* to:do throw error message to frontend */
            return Project(name: "Error", start: "Error", end: "Error", clients: [], progress: 0, notes: "Error")
        }
    }
}

