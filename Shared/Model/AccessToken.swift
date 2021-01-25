//
//  AccessToken.swift
//  Chimp
//
//  Created by Sean Saoirse on 13.01.21.
//

import Foundation

struct NewAccessTokenRequestModel:Codable{
    let user_uid: String?
}

struct NewAccessTokenResponseModel:Codable{
    let msg: String?
    let token: String?
}

