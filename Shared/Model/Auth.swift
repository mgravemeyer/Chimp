import Foundation
import CoreData

struct AuthRequestModel: Codable{
    let email: String
    let password: String
}
struct AuthResponseModel: Codable{
    let msg: String?
    let token: String?
    let user_uid: String?
//    let errors: [Errors]?
}



//struct Errors: Codable{
//    let msg: String?
//    let param: String?
//}

//Deauth models are  in this file since they're still in fact 'Authentication'
struct DeauthRequestModel: Codable{
    let user_uid: String
}
struct DeauthResponseModel: Codable{
    let msg: String?

}
