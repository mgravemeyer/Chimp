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
    
    enum CodingKeys: String, CodingKey{
        
        case id = "contact_uid"
        case firstname = "first_name"
        case lastname = "last_name"
        case email
        case phone
        case dob
        case note
        case company_uids
        case tag_uids
        case project_uids

    }
    
}

struct Contact_S_ResponseModel:Codable{
    let msg: String?
    let contact_uid: String?
}
