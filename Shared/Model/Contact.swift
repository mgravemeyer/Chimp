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
