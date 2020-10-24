//
//  SignIn.swift
//  Chimp
//
//  Created by Sean on 18.10.20.
//

import Foundation
import CoreData

struct AuthRequestModel: Codable{
    let email: String
    let password: String
}
struct AuthResponseModel: Codable{
    let msg: String?
    let token: String?
    let user_uid: String?
//    let errors: [Errors]?
}

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



//struct Errors: Codable{
//    let msg: String?
//    let param: String?
//}
