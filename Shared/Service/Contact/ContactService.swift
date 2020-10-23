//
//  ContactService.swift
//  Chimp
//
//  Created by Sean on 22.10.20.
//

import Foundation

class ContactService{
    static let instance = ContactService()
    func addOrUpdatecontact(first_name: String, last_name: String, phone: String, email: String, dob: String, note: String, company_uids: [String], tags: [String], option: ContactOptions,completed: @escaping(Result<[String:String], ContactErrors>)->Void){
        ContactRequestMaker.instance.addOrUpdate(first_name: first_name, last_name: last_name, phone: phone, email: email, dob: dob, note: note, company_uids: company_uids, tags: tags, option: .addContact) { (requestBuilt, request) in
            if requestBuilt{
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let result = try? JSONDecoder().decode(Contact_S_ResponseModel.self,from: data!) else{
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse else{
                        return
                    }
                    if(httpResponse.statusCode == 200){
                        if let contact_uid = result.contact_uid{
                            completed(.success(["contact_uid" : contact_uid])) //just in case if needed
                        }
                    }else{
                        //please read docs to fully understand all errors
                        if let errMsg  = result.msg{
                            //will fire if error contains only one property, that is msg
                            completed(.failure(.generalErrorContact))
                            print("error msg: \(errMsg)") // for debugging purposes
                        }else{
                            //* (read on the bottom of the file for a brief explanation)
                            completed(.failure(.generalErrorContact))
                            print("error result: \(result)") // for debugging purposes
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
    }
}



//*
//This will fire if request from frontend/this app is INCOMPLETE.
//from the backend, the result is not structured as a single error. Thus, result.msg isn't available.
//This error is usually structured as many errors in an array,
//This is may also be caused by BADLY/ILLEGALY formatted data for the user (e.g email address without domain).
//If it is still unclear, please read API's docs :)
//Or even try the API via postman first!
