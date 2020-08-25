//
//  ContentView.swift
//  Shared
//
//  Created by Maximilian Gravemeyer on 25.08.20.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @State var username = String()
    @State var password = String()
    @State var response = String()
    var body: some View {
        HStack {
            Image("Chimp_Logo").resizable().frame(width: 100, height: 100)
            VStack {
                TextField("Username", text: self.$username)
                TextField("Password", text: self.$password)
                Text(self.response)
                HStack {
                    Button("Sign In") {
                        self.response = "SignedIn"
                    }
                    Button("Sign Up") {
                        self.response = "SignedUp"
                    }
                }
            }.frame(width: 200)
        }.frame(minWidth: 400, idealWidth: 900, maxWidth: .infinity, minHeight: 200, idealHeight: 500, maxHeight: .infinity)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
