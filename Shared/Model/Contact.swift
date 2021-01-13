import Foundation

struct Contact: Identifiable, Hashable, Equatable, Codable {
    let id: String
    private(set) var firstname: String
    private(set) var lastname: String
    private(set) var email: String
    private(set) var phone: String
    var dob: String // Display as string
    var note: String // Display as string
    var company_uids: [String]
    var tag_uids: [String]
    var project_uids: [String]
//    private(set) var company: String
    func getGroup() -> Character {
        return lastname.first!
    }
}

struct Contact_S_RequestModel:Codable{
    let id: String // don't forget to update Contact's CoreData Model to include an "id" attribute
    let first_name: String?
    let last_name: String?
    let phone: String?
    let email: String?
    let dob: Int? // will be saved on DB as Int (epoch).
    let note: String?
    let company_uids: [String]?
    let tag_uids: [String]?
    let project_uids: [String]?
}

struct Contact_S_ResponseModel:Codable{
    let msg: String?
    let contact_uid: String?
}
