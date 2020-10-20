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
    
    func authUserService(email: String, password: String, option: AuthOptions) {
        AuthService.instance.authUserService(email: email, password: password, option: option) { (result) in
            switch result {
            case .success(let response):
                guard let token = response["token"], let user_uid = response["user_uid"] else {
                    return
                }
                print("Token \(token)")
                print("User UID \(user_uid)")
                //TODO: Persist token & user_uid
                
                DispatchQueue.main.async {
                    self.loggedIn = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
