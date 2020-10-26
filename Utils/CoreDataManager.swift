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
