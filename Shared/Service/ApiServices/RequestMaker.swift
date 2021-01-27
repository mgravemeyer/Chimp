import Foundation

struct RequestMaker{
    static let instance = RequestMaker()
    
    func makeJSONRequest(method: String, url: URL?, jsonData:Data, isPrivate: Bool, token: String)->URLRequest {
        guard let requestURL = url else { fatalError("Unexpected error when unwrapping request URL value")}
        var request = URLRequest(url: requestURL)
        request.httpMethod = method
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if isPrivate{
            request.addValue(token, forHTTPHeaderField: "x-auth-token")
        }
        return request
    }
}
