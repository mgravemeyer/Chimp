import Foundation
import CoreData
import SwiftUI

class ProjectsState: ObservableObject {
    
    init() {
        fetchProjects()
    }
    
    @Published var projects = [Project]()
    @Published var addMenuePressed = false
    @Published var selectedProject = ""
    
    func selectProject(project: UUID) {
        selectedProject = project.uuidString
    }
    
    func fetchProjects() {
        let fetchResult = CoreDataService.shared.fetchProjects()
        if fetchResult.0 == nil {
            self.projects.append(contentsOf: fetchResult.1)
        }
        /* to:do error handling */
    }
    
    func createProject(project: Project) {
        let saveResult = CoreDataService.shared.saveProject(projectData: project)
        if saveResult == nil {
            /* to:do save contact via api */
            projects.append(project)
        }
        /* to:do error handling */
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

