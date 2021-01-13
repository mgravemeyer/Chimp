import Foundation

class ContactService{
    static let instance = ContactService()
    private let contactRequest = ContactRequest.instance

    func addContact(contact: Contact){
        let request = contactRequest.createAddContactRequest(contact: contact)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("No data returned from server")
                return
            }
            guard let result = try? JSONDecoder().decode(Contact_S_ResponseModel.self,from: data) else{
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else{
                return
            }
            
            print(httpResponse)

            
            if(httpResponse.statusCode == 200){
            }else{

                if let zz = result.msg{
                    print(zz)
                }else{
                  print(httpResponse)
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
    

}
