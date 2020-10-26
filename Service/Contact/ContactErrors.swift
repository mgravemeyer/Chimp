//
//  ContactErrors.swift
//  Chimp
//
//  Created by Sean on 22.10.20.
//

import Foundation

enum ContactErrors: String, Error {
    case generalErrorContact = "Oopsie! There was an error in creating a new contact. Please try again."
}

extension ContactErrors: LocalizedError {
    var errorDescription: String? {return NSLocalizedString(rawValue, comment: "")}
}
