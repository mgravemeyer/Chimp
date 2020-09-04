//
//  LoginView.swift
//  Shared
//
//  Created by Maximilian Gravemeyer on 25.08.20.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userState: UserState
    @State var email = String()
    @State var password = String()
    @State var error = String()
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
                        Button {
                            self.userState.signIn(email: self.email, password: self.password)
                        } label: {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .frame(minWidth: 230)
                                .foregroundColor(Color.black)
                        }
                        Button {
                            self.userState.signUp(email: self.email, password: self.password)
                        } label: {
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .frame(minWidth: 230)
                                .foregroundColor(Color.blue)
                        }
                        if error != "" {
                            Text(self.error)
                                .fontWeight(.semibold)
                            frame(minWidth: 230)
                                .foregroundColor(Color.red)
                        }
                    }.frame(width: 260)
                }.frame(width: 350)
            }.frame(width: 500, height: 600).padding(.bottom, 70)
        }.frame(width: 1000, height: 600).background(Color.white)
    }
}
