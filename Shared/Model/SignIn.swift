//
//  SignIn.swift
//  Chimp
//
//  Created by Sean on 18.10.20.
//

import Foundation

struct SignInRequest: Codable{
    let email: String
    let password: String
}
struct AuthResponse: Codable{
    let msg: String?
    let token: String?
    let user_uid: String?
    let errors: [Errors]?
}
struct Errors: Codable{
    let msg: String?
    let param: String?
}
