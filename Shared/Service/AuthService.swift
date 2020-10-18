//
//  AuthService.swift
//  Chimp
//
//  Created by Sean on 19.10.20.
//

import Foundation

class AuthService{
    static let instance = AuthService()
    
    func signInUser(email: String, password: String, loginComplete: @escaping(_ result: Bool, _ resData: [String: Any]) -> ()){
        
        RequestMakerService.instance.signInUserRequest(email: email, password: password) { (requestBuilt, request) in
            if requestBuilt{
                print(request)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let result = try? JSONDecoder().decode(AuthResponse.self,from: data!) else{
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse else{
                        return
                    }
                    if(httpResponse.statusCode == 200){
                        if let token = result.token, let user_uid = result.user_uid{
                            loginComplete(true, ["token": token, "user_uid": user_uid])
                        }
                        
                    }else{
                        if let msg = result.msg{
                            //will fire if user entered data with correct format and validation, but can't be found in db...
                            loginComplete(false, ["msg": msg])
                            print("Login error. Please enter your credentials again")
                        }else{
                            //will fire if request from frontend/this app is incomplete / user entered badly/illegaly formatted data
                            // In some endpoints there might be more than one error
                            // that is sent at once - that is why there's a loop below.
                            // Example endpoint: /api/company/ (POST)
                            // If it is still unclear, please read API's docs :)
                            // Or even try the API via postman first!
                            var errDict = [String: Any]()
                            var errArrays = [String]()
                            
                            if let errors = result.errors{
                                
                                if errors.count > 1 {
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
            }else{
                
            }
            
        }
        
    }
    
    
}



