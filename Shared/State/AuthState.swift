//
//  UserState.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 03.09.20.
//

import Foundation

class AuthState: ObservableObject {

    // TODO: get variable from userdefaults
    @Published var loggedIn = false
    func authUser(email: String, password: String, option: AuthOptions, completed: @escaping(_ status: Bool, _ result: [String: String])->()) {
        AuthService.instance.authUser(email: email, password: password, option: option) { (result) in
            switch result {
            case .success(let response):
//                guard let token = response["token"], let user_uid = response["user_uid"] else {
//                    return
//                }
//                print("Token \(token)")
//                print("User UID \(user_uid)")
                DispatchQueue.main.async {
                    self.loggedIn = true
                }
                completed(true, response) // to be persisted on this function caller's file
            case .failure(let error):
                print(error.localizedDescription)
                completed(false, ["": ""])
            }
        }
    }
    
}
