//
//  RequestMakerService.swift
//  Chimp
//
//  Created by Sean on 19.10.20.
//

import Foundation

class AuthRequestMaker{
    static let instance = AuthRequestMaker()
    
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
    
    func createAuthRequest(email: String, password: String, option: AuthOptions, requestBuilt: @escaping(_ status: Bool, _ result: URLRequest)->()){
        var url = URL(string: "")
        switch option {
        case .signIn:
            url = URL(string: SIGN_IN_ENDPOINT)
        case .signUp:
            url = URL(string: SIGN_UP_ENDPOINT)
        }
        guard  let jsonData = try? JSONEncoder().encode(AuthRequestModel(email: email, password: password)) else {
            return
        }
        
        let request = requestMaker.makeJSONRequest(method: "POST", url: url, jsonData: jsonData, isPrivate: false, token: "")
        requestBuilt(true, request)
    }
    
    func createDeauthRequest(user_uid: String, token: String ,completed: @escaping(_ status: Bool,_ result: URLRequest)->()){
        let url = URL(string: SIGN_OUT_ENDPOINT)
        guard let jsonData = try? JSONEncoder().encode(DeauthRequestModel(user_uid: user_uid)) else {return}
        let request = requestMaker.makeJSONRequest(method: "POST", url: url, jsonData: jsonData, isPrivate: true, token: token)
        completed(true, request)
    }
    
}

