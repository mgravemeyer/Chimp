import Foundation
import CoreData
import SwiftUI

class ProjectsState: ObservableObject {
    var projects = [Project]()
    
    func addProject(name: String, progress: Int) {
        projects.append(Project(name: name, progress: progress))
    }
}
