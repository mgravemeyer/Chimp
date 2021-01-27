import SwiftUI

struct Project: Identifiable, Hashable, Equatable, Codable {
    let id: String
    var name: String
    var start: String
    var end: String
    var clients: [UUID]
    var progress: Int
    var notes: String
    var status: String
    var tag_uids: [String]
    var due: String
    
    enum CodingKeys: String, CodingKey{ // sent to the API
        
        case id = "project_uid"
        case name = "project_name"
        case start = "project_starts"
        case end = "project_ends"
        case clients // ? API doesn't need this - adding a client for a project is done from the Client (Contact) itself
        case progress // ? API doesn't need this
        case notes = "project_note"
        case status = "project_status"
        case tag_uids
        case due = "project_due"

    }
}

struct Project_ResponseModel:Codable{
    let msg: String?
    let project_uid: String?
}
