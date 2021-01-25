import Foundation
import CoreData
import SwiftUI
class AuthState: ObservableObject {
    
    init() {
        //TO:DO: creating fetch request auth state from core data
        //checkAuth(authDetail: T##FetchedResults<AuthDetail>)
    }
    static let instance = AuthState()

    @Published var loggedIn = false
    @Published var token = ""
    @Published var user_uid = ""
    @Published var authLoading = true

    private let authService = AuthService.instance
    private let authHelper = AuthHelper.instance

    func checkAuth() {
        let authStateFetched = CoreDataService.shared.fetch("AuthDetail").1
        if !authStateFetched.isEmpty || authStateFetched != [] {
            
            var user_uid = String()
            var token = String()
            
            for result in authStateFetched as [NSManagedObject] {
                user_uid = result.value(forKey: "user_uid") as! String
                token = result.value(forKey: "token") as! String
            }
            
            if user_uid != "" && token != "" { // just to double check
                DispatchQueue.main.async{
                    self.token = token
                    self.user_uid = user_uid
                    self.loggedIn = true
                }
            }
        }
        
        DispatchQueue.main.async{
            self.authLoading = false
        }
    }
    
   
    
    func authUser(email: String, password: String, option: AuthOptions) {
        authService.authUser(email: email, password: password, option: option) {[unowned self] (result) in
            switch result {
            case .success(let response):
                self.saveAuthDetail(result: response,  viewContext: CoreDataService.shared.viewContext)
            case .failure(let err):
                print(err.localizedDescription) // maybe assign it to a state and display to user?
            }
        }
    }
    
    func deauthUser(authDetail: FetchedResults<AuthDetail>, viewContext: NSManagedObjectContext){
        authService.deauthUser(user_uid: user_uid, token: token) {[unowned self] (result) in
            switch result{
            case .success(_):
                // _ is msg (from backend)  - assign it as a var if you wanna access it.
                self.deleteAuthDetail(authDetail: authDetail, viewContext: viewContext)
            case .failure(let err):
                print(err.localizedDescription) // maybe assign it to a state and display to user?
            }
        }
        DispatchQueue.main.async {
            self.loggedIn = false
        }
    }

    private func saveAuthDetail(result: [String: String], viewContext: NSManagedObjectContext){
        guard let token = result["token"], let user_uid = result["user_uid"] else {
            return
        }

        let newAuthDetail = AuthDetail(context: viewContext)
        newAuthDetail.token = token
        newAuthDetail.user_uid = user_uid
        let saveResult = CoreDataService.shared.save()
        if(saveResult == nil){
            DispatchQueue.main.async {
                self.loggedIn = true
                self.token = token
                self.user_uid = user_uid
            }
        }
        
    }

    func deleteAuthDetail(authDetail: FetchedResults<AuthDetail>, viewContext: NSManagedObjectContext){
        for (userD) in authDetail{
            viewContext.delete(userD)
        }
        let saveResult = CoreDataService.shared.save()
            if saveResult == nil {
                DispatchQueue.main.async{
                    self.loggedIn = false
                }
            }
    }
    
    func setNewAccessToken(saved: @escaping(_ saved: Bool)->()){
        authService.newAccessToken(user_uid: authHelper.getUIDFromCD()) { (newToken) in
            if(newToken != ""){ // if new token is successfully retrieved from API (there's a token, not empty str)
                let coreDataErr = CoreDataService.shared.updateAuthDetailToken(entity: "AuthDetail", token: newToken)
                if coreDataErr == nil {
                    DispatchQueue.main.async {
                        self.token = newToken
                    }
                    saved(true)
                }else{
                    saved(false)
                }
            }else{
                saved(false)
            }
           
        }
     

    }
    
}
