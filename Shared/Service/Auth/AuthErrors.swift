//
//  AuthError.swift
//  Chimp (iOS)
//
//  Created by Sean on 21.10.20.
//

import Foundation

enum AuthErrors: String, Error {
    case userNotFound = "No user in db!"
    case incorrectInput = "Make sure to fill in all necessary field(s) correctly!"
}

extension AuthErrors: LocalizedError {
    var errorDescription: String? {return NSLocalizedString(rawValue, comment: "")}
}
