//
//  LoginView.swift
//  Shared
//
//  Created by Maximilian Gravemeyer on 25.08.20.
//

import SwiftUI

struct User: Identifiable {
    let id = UUID()
    var email: String
    var password: String
}


struct LoginView: View {
    
    func signIn() {
        
        // TODO: async, side thread
        
        let url = URL(string: "http://127.0.0.1:5000/api/auth/sign-up")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let json : [String:Any] = ["email":"\(self.email)", "password":"\(self.password)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Data: \(dataString)")
            }
        }
        task.resume()
    }

    @State var email = String()
    @State var password = String()
    @Binding var loggedIn: Bool
    var body: some View {
        HStack {
            Group {
                Image("Login_Background").resizable().frame(width: 500, height: 600)
            }.frame(width: 500, height: 600)
            Group {
                VStack {
                    Text("Chimp")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .padding(10)
                    Text("The Tool That Doesnt Let You Look Like A Monkey")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                    Group {
                        TextField("Username", text: self.$email).textFieldStyle(PlainTextFieldStyle()).padding(.bottom, 5)
                        SecureField("Password", text: self.$password).textFieldStyle(PlainTextFieldStyle()).padding(.bottom, 5)
                    }.frame(width: 260)
                    VStack {
                        Button(action: signIn) {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .frame(minWidth: 230)
                                .foregroundColor(Color.black)
                        }
                        Button(action: signIn) {
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .frame(minWidth: 230)
                                .foregroundColor(Color.blue)
                        }
                    }.frame(width: 260)
                }.frame(width: 350)
            }.frame(width: 500, height: 600).padding(.bottom, 70)
        }.frame(width: 1000, height: 600).background(Color.white)
    }
}
