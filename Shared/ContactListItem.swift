//
//  ContactListItem.swift
//  Chimp (iOS)
//
//  Created by Maximilian Gravemeyer on 04.09.20.
//

import Foundation

struct ContactListItem: View {
    @State var contact: Contact
    var body: some View {
        VStack {
            HStack {
                Text("\(contact.firstname)").padding(.trailing, -5)
                Text("\(contact.lastname)").fontWeight(.bold)
            }
        }
    }
}
