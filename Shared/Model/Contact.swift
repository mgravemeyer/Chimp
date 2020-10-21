//
//  Contact.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 02.09.20.
//

import Foundation

struct Contact: Identifiable, Hashable {
    let id = UUID()
    private(set) var firstname: String
    private(set) var lastname: String
    private(set) var email: String
    private(set) var telephone: String
    private(set) var birthday: String
    private(set) var company: String
    
    func getGroup() -> Character {
        return lastname.first!
    }
}

struct Contact_S_RequestModel:Codable{
    let first_name: String?
    let last_name: String?
    let phone: String?
    let email: String?
    let dob: String?
    let note: String?
    let company_uids: [String]?
    let tags: [String]?
}

struct Contact_S_ResponseModel:Codable{
    let msg: String?
    let contact_uid: String?
}
