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
                guard let status = try? JSONDecoder().decode(AuthResponse.self,from: data!) else{
                    return
                }
                guard let dataRes = response as? HTTPURLResponse else{
                    return
                }
                if(dataRes.statusCode == 200){
                    print("success")
                    if let token = status.token, let user_uid = status.user_uid{
                        print("token: \(token)")
                        print("user_uid: \(user_uid)")
                        
                        //TODO: persist token & user_uid
                        
                        self.loggedIn = true
                    }
                    
                }else{
                    if let msg = status.msg{
                        if(msg == "invalid_credentials"){
                            //Invalid credentials - no matching username & password in DB
                            //Possible: wrong email, wrong password, or both
                            print("Login error. Please enter your credentials again")
                        }
                    }else{
                        //if below is unclear, please read API docs :)
                        //or even try the API via postman first!
                        if let errors = status.errors{
                            for err in errors{
                                guard let msg = err.msg, let param = err.param else{
                                    return
                                }
                                print("\(msg) --- Please re-enter: \(param)")
                            }
                        }
                    }
                }
            if let error = error {
                //this will only happen if there's a bug in this (Swift) code (?)
                print("Error: \(error)")
                return
            }
        }
        task.resume()
    }
    
}
