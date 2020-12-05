//
//  ChimpAppView.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 27.08.20.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var contactsState: ContactsState
    @EnvironmentObject var authState: AuthState
    var body: some View {
        ZStack {
            Color.white
            HStack {
                SideNavigationView().environmentObject(authState)
                VStack {
                    ContactsView()
                }
            }
        }.frame(minWidth: 900, minHeight: 500)
    }
}

struct TagView: View {
    @State var tagText: String
    var body: some View {
        Text(tagText)
            .frame(width: 100, height: 20)
            .foregroundColor(Color.white)
            .background(Color.orange)
            .cornerRadius(10)
    }
}
