//
//  LoginView.swift
//  Shared
//
//  Created by Maximilian Gravemeyer on 25.08.20.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var authState: AuthState
    @State var email = String()
    @State var password = String()
    @State var error = String()
    
    @FetchRequest(sortDescriptors: [])
    private var userDetail: FetchedResults<UserDetail>
    
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
                            self.authState.authUser(email: self.email, password: self.password, option: .signIn)
                        } label: {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .frame(minWidth: 230)
                                .foregroundColor(Color.black)
                        }
                        Button {
                            self.authState.authUser(email: self.email, password: self.password, option: .signUp)
                        } label: {
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .frame(minWidth: 230)
                                .foregroundColor(Color.blue)
                        }
//                        Button {
//                            saveCdata()
//                        } label: {
//                            Text("Test save  CDATA ")
//                                .fontWeight(.semibold)
//                                .frame(minWidth: 230)
//                                .foregroundColor(Color.blue)
//                        }
                        Button {
                            printCdata()
                        } label: {
                            Text("Test printtt  CDATA ")
                                .fontWeight(.semibold)
                                .frame(minWidth: 230)
                                .foregroundColor(Color.blue)
                        }
                        Button {
                            for userD in userDetail{
                                viewContext.delete(userD)
                            }
                            do{
                                try viewContext.save()
                            }catch{
                                let err = error as NSError
                                fatalError("cData save err: \(err)")
                            }
                        } label: {
                            Text("delete cdata  CDATA ")
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
    
    private func saveCdata(token: String, user_uid: String){
        let newUdtail = UserDetail(context: viewContext)
        newUdtail.token = token
        newUdtail.user_uid = user_uid
        do{
            try viewContext.save()
        }catch{
            let err = error as NSError
            fatalError("cData save err: \(err)")
        }
    }
    
    private func printCdata(){
        for (ix,userD) in userDetail.enumerated(){
            print(ix)
            guard let user_uid = userD.user_uid, let token = userD.token else  {
                return
            }
            print(user_uid)
            print(token)
        }
    }
}
