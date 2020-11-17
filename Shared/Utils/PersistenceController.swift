//
//  PersistenceController.swift
//  Chimp
//
//  Created by Sean on 25.10.20.
//

import Foundation
import CoreData

struct PersistenceController{
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    init(){
        container = NSPersistentContainer(name: "Chimp")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error to load persistent store: \(error)")
            }
            
            //core data stack is ready to be used
    
            
        }
    }
}
