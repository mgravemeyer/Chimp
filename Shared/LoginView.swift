//
//  LoginView.swift
//  Shared
//
//  Created by Maximilian Gravemeyer on 25.08.20.
//

import SwiftUI

struct LoginView: View {
    @State var username = String()
    @State var password = String()
    @Binding var loggedIn: Bool
    var body: some View {
        HStack {
            Image("Chimp_Logo").resizable().frame(width: 100, height: 100)
            VStack {
                TextField("Username", text: self.$username)
                SecureField("Password", text: self.$password)
                HStack {
                    Button("Sign In") {
                        self.loggedIn = true
                    }
                    Button("Sign Up") {
                        self.loggedIn = true
                    }
                }
            }.frame(width: 200)
        }.frame(width: 400, height: 200)
    }
}
