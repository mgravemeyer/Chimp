import Foundation

enum ContactErrors: String, Error {
    case generalErrorContact = "There was an error in creating a new contact. Please try again."
    case tokenExpired = "TokenExpired"

}

extension ContactErrors: LocalizedError {
    var errorDescription: String? {return NSLocalizedString(rawValue, comment: "")}
}
