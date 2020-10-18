//
//  RequestMakerService.swift
//  Chimp
//
//  Created by Sean on 19.10.20.
//

import Foundation
class RequestMakerService{
    static let instance = RequestBuilderService()

    private var restAPIHost = "http://127.0.0.1:5000/api"
    private var _AUTH_ = "auth"

    
    
    var SIGN_IN_ENDPOINT: String {
            return "\(restAPIHost)/\(_AUTH_)/sign-in"
    }
    
    func signInUserRequest(email: String, password: String, requestBuilt: @escaping(_ status: Bool, _ result: URLRequest)->()){
        let url = URL(string: SIGN_IN_ENDPOINT)
        guard let requestUrl = url else { return }
        let jsonData = try? JSONEncoder().encode(SignInRequest(email: email, password: password))
        
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        requestBuilt(true, request)
    }
    
}

