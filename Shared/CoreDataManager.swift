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
    func save(viewCont: NSManagedObjectContext){
        do{
            try viewCont.save()
        }catch{
            let err = error as NSError
            fatalError("cData save err: \(err)")
        }
    }
    
}
