import Foundation

class AuthService{
    static let instance = AuthService()
    private let authRequest = AuthRequest.instance
    
    func authUser(email: String, password: String, option: AuthOptions,  loginCompleted: @escaping(Result<[String:String], AuthErrors>) -> Void){
        let request = authRequest.createAuthRequest(email: email, password: password, option: option)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("No data returned from server")
                return
            }
            guard let result = try? JSONDecoder().decode(AuthResponseModel.self,from: data) else{
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else{
                return
            }
            if(httpResponse.statusCode == 200){
                if let token = result.token, let user_uid = result.user_uid{
                    loginCompleted(.success(["token": token, "user_uid": user_uid]))
                }
                
            }else{
                //please read docs to fully understand all errors
                if let _ = result.msg{
                    switch option {
                    case .signIn:
                        loginCompleted(.failure(.userNotFound))
                    case .signUp:
                        loginCompleted(.failure(.userAlreadyExists))

                    }
                    //will fire if user entered data with correct format and validation, but can't be found in db...
                }else{
                    //* (read on the bottom of the file for a brief explanation)
                    switch option {
                    case .signIn:
                        loginCompleted(.failure(.incorrectInputSignIn))
                    case .signUp:
                        loginCompleted(.failure(.incorrectInputSignUp))
                        
                    }
                }
            }
            if let error = error {
                //unsure, but this may happen only if there's a bug in this (Swift) code (?)
                print("Error: \(error)")
                return
            }
        }
        task.resume()
    }
    
    func deauthUser(user_uid: String, token: String, loggedOutCompleted: @escaping(Result<[String:String], DeauthErrors>)->()){
        let request = authRequest.createDeauthRequest(user_uid: user_uid, token: token)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("No data returned from server")
                return
            }
            guard let result = try? JSONDecoder().decode(DeauthResponseModel.self,from: data) else{
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else{
                return
            }
            if(httpResponse.statusCode == 200){
                guard let msg = result.msg else {return}
                loggedOutCompleted(.success(["msg" : msg]))
            }else{
                //please read docs to fully understand all errors
                if let _ = result.msg{
                    //will fire if user_uid is sent, but user_uid can't be  found in db...
                    loggedOutCompleted(.failure(.incorrectInputSignUp))
                }else{
                    //* (read on the bottom of the file for a brief explanation)
                    loggedOutCompleted(.failure(.userUidNotFound))
                }
            }
            if let error = error {
                //unsure, but this may happen only if there's a bug in this (Swift) code (?)
                print("Error: \(error)")
                return
            }
        }
        task.resume()
    }
    
    func newAccessToken(user_uid: String, newToken: @escaping(_ newToken: String)->()){
        let request = authRequest.createAccessTokenRequest(user_uid: user_uid)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("No data returned from server")
                return
            }
            guard let result = try? JSONDecoder().decode(NewAccessTokenResponseModel.self,from: data) else{
                print("no result")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else{
                print("no response")
                return
            }
            
            print(httpResponse)

            
            
            if(httpResponse.statusCode == 200){
                if let token = result.token{
                    newToken(token) // new token
                }
                
            }else{

                if let errMsg = result.msg{
                   print(errMsg)
                }
                newToken("") // no token because error

            }
            if let error = error {
                //unsure, but this may happen only if there's a bug in this (Swift) code (?)
                print("Error: \(error)")
                return
            }
        }
        task.resume()

    }

}

//*
//This will fire if request from frontend/this app is INCOMPLETE.
//from the backend, the result is not structured as a single error. Thus, result.msg isn't available.
//This error is usually  structured as many errors in an array,
//This is may also be caused by BADLY/ILLEGALY formatted data for the user (e.g email address without domain).
//If it is still unclear, please read API's docs :)
//Or even try the API via postman first!
