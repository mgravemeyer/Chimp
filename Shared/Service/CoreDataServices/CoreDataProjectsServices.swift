import Foundation
import CoreData
import SwiftUI

extension CoreDataService {
    func fetchProjects() -> (CoreDataErrors?, [Project]) {
        let projectsCD = fetch("ProjectDetail")
        //to:do unwrap values safely, not force unwrap
        if projectsCD.0 == nil {
            var projectsFetched = [Project]()
            for result in projectsCD.1 as [NSManagedObject] {
                let progress = result.value(forKey: "progress") as! Int
                let clients = result.value(forKey: "clients") as! String
                let end = result.value(forKey: "end") as! String
                let name = result.value(forKey: "name") as! String
                let start = result.value(forKey: "start") as! String
                let notes = result.value(forKey: "notes") as! String
                let project = Project(id: UUID().uuidString, name: name, start: start, end: end, clients: [], progress: progress, notes: notes)
                projectsFetched.append(project)
            }
            return (nil, projectsFetched)
        } else {
            return (.fetchError, [Project]())
        }
    }
    
    func saveProject(projectData: Project) -> CoreDataErrors? {
        let newProjectDetail = ProjectDetail(context: CoreDataService.shared.viewContext)
        //to:do for loop adding values
        newProjectDetail.setValue(Int16(projectData.progress), forKey: "progress")
        newProjectDetail.setValue("", forKey: "clients")
        newProjectDetail.setValue(projectData.end, forKey: "end")
        newProjectDetail.setValue(projectData.name, forKey: "name")
        newProjectDetail.setValue(projectData.notes, forKey: "notes")
        newProjectDetail.setValue(projectData.start, forKey: "start")
        
        let saveResult = save()
        if saveResult == nil {
            return nil
        } else {
            return .saveError
        }
    }
}
