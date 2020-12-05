import Foundation

enum AccessTokenErrors: String, Error {
    case expired = "Operation failed, token expired!"
}

extension AccessTokenErrors: LocalizedError {
    var errorDescription: String? {return NSLocalizedString(rawValue, comment: "")}
}
