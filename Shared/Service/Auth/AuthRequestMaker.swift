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
        guard let requestUrl = url else { return }
        let jsonData = try? JSONEncoder().encode(AuthRequestModel(email: email, password: password))
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        requestBuilt(true, request)
    }
    
    func createDeauthRequest(user_uid: String, token: String ,completed: @escaping(_ status: Bool,_ result: URLRequest)->()){
        let url = URL(string: SIGN_OUT_ENDPOINT)
        guard let requestUrl = url else { return }
        let jsonData = try? JSONEncoder().encode(DeauthRequestModel(user_uid: user_uid))
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue(token, forHTTPHeaderField: "x-auth-token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        completed(true, request)
    }
  
}

