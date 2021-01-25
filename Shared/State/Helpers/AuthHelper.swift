//
//  AuthHelper.swift
//  Chimp
//
//  Created by Sean Saoirse on 13.01.21.
// What is this?
// This is a helper file that relates to Auth
// Contains many helper functions that are called frequently from different files/places.

import Foundation
import CoreData

class AuthHelper{
    static let instance = AuthHelper()
    
    func getTokenFromCD() -> String {
        let authStateFetched = CoreDataService.shared.fetch("AuthDetail").1
        var token = String()
        for result in authStateFetched as [NSManagedObject] {
            token = result.value(forKey: "token") as! String
        }
        return token
    }
    func getUIDFromCD() -> String {
        let authStateFetched = CoreDataService.shared.fetch("AuthDetail").1
        var user_uid = String()
        for result in authStateFetched as [NSManagedObject] {
            user_uid = result.value(forKey: "user_uid") as! String
        }
        return user_uid
    }

    
}
