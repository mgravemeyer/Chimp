//
//  ContactView.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 13.11.20.
//

import SwiftUI

struct ContactAddView: View {
 
    //CoreData stack for ContactDetail
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var contactsDetail: FetchedResults<ContactDetail>

    @EnvironmentObject var contactsState: ContactsState
    @EnvironmentObject var authState: AuthState
    let gray = Color(red: 207/255, green: 207/255, blue: 212/255)
    let lightGray = Color(red: 240/255, green: 240/255, blue: 240/255)
    
    @State var contactData = ["first_name": "", "last_name": "", "phone": "", "email": "", "dob": "", "note": ""] // dob is date of birth
    @State var birthDate = Date()
    @State var selected = false
    @State var hoverRow = false
        
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        // TODO: make view over window toolbar items, close but should overlay the toolbar items
                        Button("Close") {
                            contactsState.addMenuePressed.toggle()
                        }.padding(.trailing, 20).padding(.top, 30)
                        Button("Print cdata contact") {
                            for (_,contactDetail) in contactsDetail.enumerated(){
                                guard let fname = contactDetail.first_name, let lname = contactDetail.last_name, let phone = contactDetail.phone , let email = contactDetail.email, let note = contactDetail.note  else {return}
                                let dob = contactDetail.dob
                                print("\(fname) \(lname)'s birthday is on \(dob)")
                                print("Phone: \(phone)")
                                print("Email: \(email)")
                                print("Note: \(note)")
                            }
                        }.padding(.trailing, 20).padding(.top, 30)
                        Button {
                            for (contactD) in contactsDetail{
                                viewContext.delete(contactD)
                                CoreDataManager.instance.save(viewContext: viewContext){(_)in}
                            }
                            
                        } label: {
                            Text("delete cdata ")
                                .fontWeight(.semibold)
                                .frame(minWidth: 230)
                                .foregroundColor(Color.blue)
                        }
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Text("Add").font(.system(size: 30)).fontWeight(.bold).zIndex(1)
                            Text("Contact").font(.system(size: 30)).fontWeight(.light).zIndex(1)
                        }
                        HStack {
                            ChimpTextField(placeholder: "First Name", value: self.binding(for: "first_name"))
                            ChimpTextField(placeholder: "Last Name", value: self.binding(for: "last_name"))
                        }
                        
                        ChimpTextField(placeholder: "E-Mail", value: self.binding(for: "email"))
                        ChimpTextField(placeholder: "Telephone", value: self.binding(for: "phone"))
                        
                        ChimpDatePicker(birthDate: self.$birthDate)
                       
                        ZStack(alignment: .center) {
                            HStack {
                                    Image(systemName: "square.and.arrow.down")
                                    Text("Save").fontWeight(.bold)
                            }.zIndex(1)
                            RoundedRectangle(cornerRadius: 20).foregroundColor(selected || hoverRow ? gray : lightGray).onHover { (hover) in
                                self.hoverRow = hover
                            }
                        }.onTapGesture {
                            // TODO: save new contact function to the DB
                            contactData["dob"] = String(Int(birthDate.timeIntervalSince1970*1000)) // d.o.b in epoch in string format
                            self.contactsState.createContactCD(contactData: contactData, ,viewContext: viewContext)
                          
                            contactsState.addMenuePressed.toggle()
                        }
                    }.frame(maxWidth: 320, maxHeight: 320)
                    Spacer()
                }.padding(.bottom, 50).zIndex(1).frame(width: geometry.size.width, height: geometry.size.height).background(Color.white).opacity(0.97)
            }
        }
    }
    
    //this is used to bind [String:String]
    //(as it's not possible using $)
    private func binding(for key: String) -> Binding<String> {
       return .init(
        get: { (self.contactData[key, default: ""] )},
           set: { self.contactData[key] = $0 })
    }
    
}

//TO:DO: PUT FUNTION INTO CLASS OR STRUCT
func createExternalContactDetailViewWindow(contact: Contact) {
    let mousePos = NSEvent.mouseLocation
    var windowRef:NSWindow
    windowRef = NSWindow(
        contentRect: NSRect(x: mousePos.x, y: mousePos.y, width: 300, height: 400),
        styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView, .resizable],
        backing: .buffered, defer: false)
    windowRef.contentView = NSHostingView(rootView: ExternalContactDetailView(contact: contact, myWindow: windowRef))
    windowRef.makeKeyAndOrderFront(nil)
}
