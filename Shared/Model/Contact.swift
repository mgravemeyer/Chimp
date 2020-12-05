import Foundation

struct Contact: Identifiable, Hashable, Equatable {
    let id = UUID()
    private(set) var firstname: String
    private(set) var lastname: String
    private(set) var email: String
    private(set) var telephone: String
    var birthday: String // Display as string
    private(set) var company: String
    
    func getGroup() -> Character {
        return lastname.first!
    }
}

struct Contact_S_RequestModel:Codable{
    let first_name: String?
    let last_name: String?
    let phone: String?
    let email: String?
    let dob: Int? // will be saved on DB as Int (epoch).
    let note: String?
    let company_uids: [String]?
    let tags: [String]?
}

struct Contact_S_ResponseModel:Codable{
    let msg: String?
    let contact_uid: String?
}
