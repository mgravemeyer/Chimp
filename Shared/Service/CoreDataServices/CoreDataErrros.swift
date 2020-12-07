import Foundation

enum CoreDataErrors: String, Error {
    case fetchError = "Couldnt fetch data from coreData"
    case saveError = "Couldnt save data to coreData"
}
