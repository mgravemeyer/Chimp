import Foundation
import CoreData
import SwiftUI

class ProjectsState: ObservableObject {
    
    @Published var projects = [Project]()
    @Published var addMenuePressed = false
    
    func addProject(name: String, progress: Int) {
        projects.append(Project(name: name, progress: progress))
    }
}
