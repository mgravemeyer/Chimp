//
//  RequestMaker.swift
//  Chimp
//
//  Created by Sean on 25.10.20.
//

import Foundation

struct RequestMaker{
    static let instance = RequestMaker()
    
    func makeRequest(method: String, url: URL?, jsonData:Data)->URLRequest {
        guard let requestURL = url else { fatalError("Unexpected error when unwrapping request URL value")}
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
