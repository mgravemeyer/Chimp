import Foundation

enum ProjectErrors: String, Error {
    case generalErrorProject = "There was an error in creating a new contact. Please try again."
    case tokenExpired = "TokenExpired"

}

extension ProjectErrors: LocalizedError {
    var errorDescription: String? {return NSLocalizedString(rawValue, comment: "")}
}
