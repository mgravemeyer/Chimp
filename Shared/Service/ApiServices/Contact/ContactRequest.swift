import Foundation

class ContactRequest{
    static let instance = ContactRequest()
    private let _REST_API_HOST_ = "http://167.99.136.248:5000/api"
    private var _CONTACT_ = "contact"
    private let requestMaker = RequestMaker.instance
    private let authHelper = AuthHelper.instance
    
    var ADD_OR_UPDATE_CONTACT_ENDPOINT: String {
        return "\(_REST_API_HOST_)/\(_CONTACT_)/"
    }
    
    func createAddContactRequest(contact: Contact)->URLRequest{
        let url = URL(string: ADD_OR_UPDATE_CONTACT_ENDPOINT)
        let token: String = authHelper.getTokenFromCD()
        
        guard  let jsonData = try? JSONEncoder().encode(Contact(id: contact.id, firstname: contact.firstname, lastname: contact.lastname, email: contact.email, phone: contact.email, dob: contact.dob, note: contact.note, company_uids: contact.company_uids, tag_uids: contact.tag_uids, project_uids: contact.project_uids)) else { fatalError("Error unwrapping JSON data")}
        return requestMaker.makeJSONRequest(method: "POST", url: url, jsonData: jsonData, isPrivate: true, token: token)
      
    }
  
}
