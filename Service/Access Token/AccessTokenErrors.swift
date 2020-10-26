//
//  AccessTokenErrors.swift
//  Chimp
//
//  Created by Sean on 22.10.20.
//

import Foundation

enum AccessTokenErrors: String, Error {
    case expired = "Operation failed, token expired!"
}

extension AccessTokenErrors: LocalizedError {
    var errorDescription: String? {return NSLocalizedString(rawValue, comment: "")}
}
