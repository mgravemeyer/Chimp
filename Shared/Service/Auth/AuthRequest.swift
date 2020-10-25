//
//  RequestMakerService.swift
//  Chimp
//
//  Created by Sean on 19.10.20.
//

import Foundation

class AuthRequest{
    static let instance = AuthRequest()
    
    private var _REST_API_HOST_ = "http://127.0.0.1:5000/api"
    private var _AUTH_ = "auth"
    
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
    
}

