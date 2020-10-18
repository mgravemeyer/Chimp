//
//  AuthService.swift
//  Chimp
//
//  Created by Sean on 19.10.20.
//

import Foundation

class AuthService{
    static let instance = AuthService()
    
    func signInUser(email: String, password: String, loginComplete: @escaping(_ status: Bool, _ resData: [String: Any]) -> ()){
        
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
                if let token = status.token, let user_uid = status.user_uid{
                    loginComplete(true, ["token": token, "user_uid": user_uid])
                }
                
            }else{
                if let msg = status.msg{
                    //will fire if user entered data with correct format and validation, but can't be found in db...
                    loginComplete(false, ["msg": msg])
                    print("Login error. Please enter your credentials again")
                }else{
                    //will fire if request from frontend/this app is incomplete / user entered badly/illegaly formatted data
                    var errDict = [String: Any]()
                    var errArrays = [String]()
                    
                    if let errors = status.errors{
                        
                        if errors.count > 1 {
                            // In some endpoints there might be more than one error
                            // that is sent at once.
                            // Example endpoint: /api/company/ (POST)
                            // If it is still unclear, please read API's docs :)
                            // Or even try the API via postman first!
                            for err in errors{
                                guard let msg = err.msg else{
                                    return
                                }
                                errArrays.append(msg)
                            }
                            errDict["msg"] = errArrays
                        }else{
                            errDict["msg"] = errors[0].msg
                        }
                        
                    }
                    loginComplete(false, errDict)
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



