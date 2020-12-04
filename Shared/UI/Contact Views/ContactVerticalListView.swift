//
//  ContactVerticalListView.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 13.11.20.
//

import SwiftUI

struct ContactVerticalListView: View {

    @EnvironmentObject var contactsState: ContactsState
    @State var categorie: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(self.categorie).font(.system(size: 30)).fontWeight(.bold).padding(.trailing, 10).frame(width: 40)
            VStack(alignment: .leading) {
                ForEach(contactsState.contacts, id: \.self) { contact in
                    if String(contact.lastname.first!) == categorie {
                        if contact.id.uuidString == contactsState.selectedContact {
                            ContactVerticalListItem(contact: contact, selected: true).padding(.bottom, 8)
                                .contextMenu {
                                    Button(action: {
                                        createExternalContactDetailViewWindow(contact: contact)
                                    }) {
                                        Text("Create New Window")
                                    }
                                    Button(action: {
                                        createExternalContactDetailViewWindow(contact: contact)
                                    }) {
                                        Text("Edit Contact")
                                    }
                                    Button(action: {
                                        createExternalContactDetailViewWindow(contact: contact)
                                    }) {
                                        Text("Delete Contact")
                                    }
                                }
                        } else {
                            ContactVerticalListItem(contact: contact, selected: false).padding(.bottom, 8)
                            .contextMenu {
                                Button(action: {
                                    createExternalContactDetailViewWindow(contact: contact)
                                }) {
                                    Text("Create New Window")
                                }
                                Button(action: {
                                    createExternalContactDetailViewWindow(contact: contact)
                                }) {
                                    Text("Edit Contact")
                                }
                                Button(action: {
                                    createExternalContactDetailViewWindow(contact: contact)
                                }) {
                                    Text("Delete Contact")
                                }
                            }
                        }
                    }
                }
            }
            Spacer()
        }.padding(.top, 20)
    }
}
//hoverRow ? lightGray : Color.white
struct ContactVerticalListItem: View {
    @EnvironmentObject var contactsState: ContactsState
    @State var contact: Contact
    @State var selected: Bool
    @State var hoverRow = false
    let gray = Color(red: 207/255, green: 207/255, blue: 212/255)
    let lightGray = Color(red: 240/255, green: 240/255, blue: 240/255)
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                    Text("\(contact.firstname)").padding(.trailing, -5).padding(.leading, 10)
                    Text("\(contact.lastname)").fontWeight(.bold)
                Spacer()
            }.zIndex(1)
            RoundedRectangle(cornerRadius: 10).foregroundColor(selected || hoverRow ? lightGray : Color.white).onHover { (hover) in
                self.hoverRow = hover
            }
        }.frame(width: 180, height: 37).padding(.bottom, -15).onTapGesture {
            contactsState.selectedContact  = contact.id.uuidString
        }
    }
}
