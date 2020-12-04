//
//  EmptyContactDetailView.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 13.11.20.
//

import SwiftUI

struct EmptyContactDetail: View {
    
    @EnvironmentObject var contactsState: ContactsState
    
    var body: some View {
        ZStack() {
            Button {
                contactsState.addMenuePressed.toggle()
            } label: {
                Text("Add Contact")
            }.zIndex(2)
            Image("Contacts_Detail").resizable().frame(width: 300, height: 300).padding(.trailing, 40).zIndex(1)
            Rectangle().foregroundColor(Color.white)
        }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 20)
    }
}
