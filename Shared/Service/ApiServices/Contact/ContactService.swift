import Foundation

class ContactService{
    static let instance = ContactService()
    private let contactRequest = ContactRequest.instance

    func addContact(contact: Contact, completed: @escaping(Result<String, ContactErrors>)->()){
        let request = contactRequest.createAddContactRequest(contact: contact)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("No data returned from server")
                return
            }
            guard let result = try? JSONDecoder().decode(Contact_ResponseModel.self,from: data) else{
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else{
                return
            }
            
            if(httpResponse.statusCode == 200){
                completed(.success("Contact successfully added to DB"))
            }else{
                if let errMsg = result.msg{
                    if errMsg == "token_expired"{
                        completed(.failure(.tokenExpired))
                    }else{
                        print("Not expired, but: \(errMsg)")
                    }
                }
            }
            if let error = error {
                //unsure, but this may happen only if there's a bug in this (Swift) code (?)
                print("Error: \(error)")
                completed(.failure(.generalErrorContact))
                return
            }
        }
        task.resume()
    }
    

}
