import Foundation

class ContactRequest{
    static let instance = ContactRequest()
    private var _REST_API_HOST_ = "http://127.0.0.1:5000/api"
    private var _CONTACT_ = "contact"
    private let requestMaker = RequestMaker.instance
    
    var ADD_OR_UPDATE_CONTACT_ENDPOINT: String {
        return "\(_REST_API_HOST_)/\(_CONTACT_)/"
    }
    
    func createAddContactRequest(first_name: String, last_name: String, phone: String, email: String, dob: Int, note: String, company_uids: [String], tag_uids: [String], project_uids: [String])->URLRequest{
        let url = URL(string: ADD_OR_UPDATE_CONTACT_ENDPOINT)
        guard  let jsonData = try? JSONEncoder().encode(Contact_S_RequestModel(id: UUID().uuidString, first_name: first_name, last_name: last_name, phone: phone, email: email, dob: dob, note: note, company_uids: company_uids, tag_uids: tag_uids, project_uids: project_uids)) else { fatalError("Error unwrapping JSON data")}

        return requestMaker.makeJSONRequest(method: "POST", url: url, jsonData: jsonData, isPrivate: true, token: "")
    }
    
//    func addOrUpdate(first_name: String, last_name: String, phone: String, email: String, dob: Int, note: String, company_uids: [String],tags: [String], option: ContactOptions, requestBuilt:  @escaping(_ status: Bool, _ request: URLRequest)-> ()){
//        var url = URL(string: "")
//
//            url = URL(string: ADD_OR_UPDATE_CONTACT_ENDPOINT)
//
//        guard let requestUrl = url else { return }
//        let jsonData = try? JSONEncoder().encode(Contact_S_RequestModel(first_name: first_name, last_name: last_name, phone: phone, email: email, dob: dob, note: note, company_uids: company_uids, tags: tags))
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "POST"
//        switch option{
//            case .addContact:
//                request.httpMethod = "POST"
//        }
//        request.httpBody = jsonData
//        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjoiMTk0MWQ1MzItYzBiYy00Y2Y5LWJhYzYtZGQxZDI5YjhhMGVkIiwiaWF0IjoxNjAzNDY3ODM2LCJleHAiOjE2MDM0Njk2MzZ9.nAtBDYoDIDgscU6q0M4HgnLDXuD1P9aFgFCn2LRhq_g", forHTTPHeaderField: "x-auth-token")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        requestBuilt(true, request)
//    }
}
