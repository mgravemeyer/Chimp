//
//  LoginView.swift
//  Shared
//
//  Created by Maximilian Gravemeyer on 25.08.20.
//

import SwiftUI

struct LoginView: View {
    
    //Core data result for AuthDetail
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var authDetail: FetchedResults<AuthDetail>
    
    @EnvironmentObject var authState: AuthState
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
                            self.authState.authUser(email: email, password: password, option: .signIn, authDetail: authDetail, viewContext: viewContext)

                        } label: {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .frame(minWidth: 230)
                                .foregroundColor(Color.black)
                        }
                        
                        Button {
                            self.authState.authUser(email: email, password: password, option: .signUp, authDetail: authDetail, viewContext: viewContext)

                        } label: {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .frame(minWidth: 230)
                                .foregroundColor(Color.blue)
                        }


                        Button {
                            printCdata()
                        } label: {
                            Text("Test printtt  CDATA ")
                                .fontWeight(.semibold)
                                .frame(minWidth: 230)
                                .foregroundColor(Color.blue)
                        }
                        Button {
                            for (userD) in authDetail{
                                viewContext.delete(userD)
                                CoreDataManager.instance.save(viewContext: viewContext){(_)in}

                            }
                            
                        } label: {
                            Text("delete cdata ")
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
    
    private func printCdata(){
        for (ix,userD) in authDetail.enumerated(){
            print(ix)
            guard let user_uid = userD.user_uid, let token = userD.token else  {
                return
            }
            print(user_uid)
            print(token)
        }
    }
}
