//
//  AuthError.swift
//  Chimp (iOS)
//
//  Created by Sean on 21.10.20.
//

import Foundation

enum AuthErrors: String, Error {
    case userNotFound = "We are unable to find any account with this email & password combination."
    case userAlreadyExists = "This account already exists!"
    case incorrectInputSignIn = "Sign in error - data isn't valid! Make sure to fill in all necessary field(s) correctly!"
    case incorrectInputSignUp = "Sign up error - data isn't valid! Make sure to fill in all necessary field(s) correctly!"
}

enum DeauthErrors: String, Error{
    case userUidNotFound = "user_uid does not exist in db!"
    case incorrectInputSignUp = "Sign up error - data isn't valid! Make sure to fill in all necessary field(s) correctly!"

}


extension AuthErrors: LocalizedError {
    var errorDescription: String? {return NSLocalizedString(rawValue, comment: "")}
}

extension DeauthErrors: LocalizedError {
    var errorDescription: String? {return NSLocalizedString(rawValue, comment: "")}
}

