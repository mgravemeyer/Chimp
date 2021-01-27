import Foundation

class ProjectRequest{
    static let instance = ProjectRequest()
    private let _REST_API_HOST_ = "http://167.99.136.248:5000/api"
    private var _PROJECT_ = "project"
    private let requestMaker = RequestMaker.instance
    private let authHelper = AuthHelper.instance
    
    var ADD_OR_UPDATE_CONTACT_ENDPOINT: String {
        return "\(_REST_API_HOST_)/\(_PROJECT_)/"
    }
    
    func createAddProjectRequest(project: Project)->URLRequest{
        let url = URL(string: ADD_OR_UPDATE_CONTACT_ENDPOINT)
        let token: String = authHelper.getTokenFromCD()
        let projStart = 0 // this should be EPOCH
        let projEnds = 0 // this should be EPOCH
        let projDue = 0 // this should be EPOCH
        //TODO use real projStart, projEnds, and projDue from frontend//
        guard  let jsonData = try? JSONEncoder().encode(Project(id: project.id, name: project.name, start: String(projStart), end: String(projEnds), clients: project.clients, progress: project.progress, notes: project.notes, status: project.status, tag_uids: project.tag_uids, due: String(projDue))) else { fatalError("Error unwrapping JSON data")}
        return requestMaker.makeJSONRequest(method: "POST", url: url, jsonData: jsonData, isPrivate: true, token: token)
      
    }
  
}
