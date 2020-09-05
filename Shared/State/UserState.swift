//
//  UserState.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 03.09.20.
//

import Foundation

class UserState: ObservableObject {
    
    // TODO: get variable from userdefaults
    @Published var loggedIn = false
    
    func signUp(email: String, password: String) {
        // TODO: async, side thread
        // TODO: error handling
        let url = URL(string: "http://127.0.0.1:5000/api/auth/sign-up")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let json : [String:Any] = ["email":"\(email)", "password":"\(password)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                let token = jsonResponse!["token"]!
                print(token)
                self.loggedIn = true
            } catch {
                print(error)
            }
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Data: \(dataString)")
            }
        }
        task.resume()
    }
    
    func signIn(email: String, password: String) {
        // TODO: async, side thread
        // TODO: error handling
        let url = URL(string: "http://127.0.0.1:5000/api/auth/sign-in")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let json : [String:Any] = ["email":"\(email)", "password":"\(password)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                let token = jsonResponse!["token"]!
                print(token)
                self.loggedIn = true
            } catch {
                print(error)
            }
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Data: \(dataString)")
            }
        }
        task.resume()
    }

}
