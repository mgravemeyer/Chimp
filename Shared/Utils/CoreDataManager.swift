//
//  SaveContext.swift
//  Chimp
//
//  Created by Sean on 24.10.20.
//

import Foundation
import CoreData
import SwiftUI
struct CoreDataManager {
    
    static let instance = CoreDataManager()
    
    func fetchRecordsForEntity(_ entity: String, inManagedObjectContext viewContext: NSManagedObjectContext) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        var result = [NSManagedObject]()
        do {
            let records = try viewContext.fetch(fetchRequest)

            if let records = records as? [NSManagedObject] {
                result = records
            }
        } catch {
            print("Unable to fetch managed objects for entity \(entity).")
        }
        return result
    }
    
    func save(viewContext: NSManagedObjectContext, saved: @escaping (_ status: Bool)->()){
        do{
            try viewContext.save()
            saved(true)
        }catch{
            saved(false)
            let err = error as NSError
            fatalError("cData save err: \(err)")
        }
    }
}
