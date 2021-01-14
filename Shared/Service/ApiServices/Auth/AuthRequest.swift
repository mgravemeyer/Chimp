import Foundation

class AuthRequest{
    static let instance = AuthRequest()
    
    private let authHelper = AuthHelper.instance

    
    private let _REST_API_HOST_ = "http://167.99.136.248:4000/api"
    private let _AUTH_ = "auth"
    
    private let requestMaker = RequestMaker.instance
    
    var SIGN_IN_ENDPOINT: String {
        return "\(_REST_API_HOST_)/\(_AUTH_)/sign-in"
    }
    var SIGN_UP_ENDPOINT: String {
        return "\(_REST_API_HOST_)/\(_AUTH_)/sign-up"
    }
    var SIGN_OUT_ENDPOINT: String {
        return "\(_REST_API_HOST_)/\(_AUTH_)/sign-out"
    }
    
    var NEW_ACCESS_TOKEN_ENDPOINT: String {
        return "\(_REST_API_HOST_)/\(_AUTH_)/new-access-token"
    }
    
    func createAuthRequest(email: String, password: String, option: AuthOptions)->URLRequest{
        var url = URL(string: "")
        switch option {
        case .signIn:
            url = URL(string: SIGN_IN_ENDPOINT)
        case .signUp:
            url = URL(string: SIGN_UP_ENDPOINT)
        }
        guard  let jsonData = try? JSONEncoder().encode(AuthRequestModel(email: email, password: password)) else { fatalError("Error unwrapping JSON data")}
       
        return requestMaker.makeJSONRequest(method: "POST", url: url, jsonData: jsonData, isPrivate: false, token: "")
    }
    
    func createDeauthRequest(user_uid: String, token: String)->URLRequest{
        let url = URL(string: SIGN_OUT_ENDPOINT)
        guard let jsonData = try? JSONEncoder().encode(DeauthRequestModel(user_uid: user_uid)) else { fatalError("Error unwrapping JSON data")}
        return requestMaker.makeJSONRequest(method: "POST", url: url, jsonData: jsonData, isPrivate: true, token: token)
    }
    
    func createAccessTokenRequest(user_uid: String)->URLRequest{
        let url = URL(string: NEW_ACCESS_TOKEN_ENDPOINT)
        let token: String = authHelper.getTokenFromCD()

        
        guard  let jsonData = try? JSONEncoder().encode(NewAccessTokenRequestModel(user_uid: user_uid)) else { fatalError("Error unwrapping JSON data")}
        return requestMaker.makeJSONRequest(method: "POST", url: url, jsonData: jsonData, isPrivate: true, token: token)
      
    }
    
}

