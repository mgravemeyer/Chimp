import Foundation
import CoreData
import SwiftUI

class ProjectsState: ObservableObject {
    private let projectService = ProjectService.instance
    private let authState = AuthState.instance

    init() {
        fetchProjects()
    }
    
    @Published var projects = [Project]()
    @Published var addMenuePressed = false
    @Published var selectedProject = ""
    
    func selectProject(project: String) {
        selectedProject = project
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
            addProjectToBackend(project: project)
        }
        /* to:do error handling */
    }
    func addProjectToBackend(project: Project){
        // this is refactored to a new func
        // instead of in the createProject() func (above)
        // is so that it's easier to call it recursively
        
        projectService.addProject(project: project) {[unowned self] (result) in
            switch result{
            case .success(let x):
                print(x)
            case .failure(let err):
                print(err.localizedDescription)
                if(err.localizedDescription == "TokenExpired"){
                    authState.setNewAccessToken { (success) in
                        if(success){
                            addProjectToBackend(project: project)// re-hits the add project endpt here
                        }
                    }
                }
                
            }

        }
        
    }
    
    func getSelectedProject() -> Project {
        if let project = projects.first(where: {$0.id == self.selectedProject}) {
            return project
        } else {
            /* to:do throw error message to frontend */
            return Project(id: UUID().uuidString,name: "Error", start: "Error", end: "Error", clients: [], progress: 0, notes: "Error", status: "Some Status", tag_uids: [], due: "0")
        }
    }
}

