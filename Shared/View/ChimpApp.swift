//
//  ChimpApp.swift
//  Shared
//
//  Created by Maximilian Gravemeyer on 25.08.20.
//

import SwiftUI

@main
struct ChimpApp: App {
   
    let persistenceController = PersistenceController.shared
    @StateObject var authState = AuthState()

    var body: some Scene {
            WindowGroup {
                AppWrapper().environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(authState)
                // this allows the whole app to access the persistent store (CoreData)

            }.windowStyle(HiddenTitleBarWindowStyle())
    }
}

struct AppWrapper: View {
    //Core data result for AuthDetail
    @FetchRequest(sortDescriptors: [])
    private var authDetail: FetchedResults<AuthDetail>
    
    //Core data result for ContactsDetail
    @FetchRequest(sortDescriptors: [])
    private var contactsDetail: FetchedResults<ContactDetail>

    
    @StateObject var contactsState = ContactsState()
    @EnvironmentObject var authState: AuthState
    
    var body: some View{
        if authState.authLoading{
            // on initial launch this will always get fired
            LoadingView().onAppear{
                self.authState.checkAuth(authDetail: authDetail)
            }
        }else{
            if !authState.loggedIn {
                LoginView()
            } else {
                ZStack {
                    Button("") {
                        contactsState.advancedMenuePressed.toggle()
                    }.keyboardShortcut("j", modifiers: .command).zIndex(-10000)
                    
                    if contactsState.addMenuePressed {
                        ContactAddView().zIndex(1)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
    //                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                            .environmentObject(contactsState)
                    }
                    if contactsState.advancedMenuePressed {
                        AdvancedMenue().zIndex(1)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
    //                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                            .environmentObject(contactsState)
                    }
                    AppView()
    //                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .environmentObject(contactsState)
                        .zIndex(0).onAppear(){
                            self.contactsState.getAllContactsFromCD(contactsDetail: contactsDetail)
                        }
                }.edgesIgnoringSafeArea(.all)
            }
        }
        }
}
    
    
struct AdvancedMenue: View {
    @EnvironmentObject var contactsState: ContactsState
    @State var advancedCommand = String()
    @State var boxHeight = CGFloat(50)
    @State var isSelected = false
    @State var geoBox = CGFloat()
    var body: some View {
        
        let binding = Binding<String>(get: {
                    self.advancedCommand
            }, set: {
                    self.advancedCommand = $0
                self.boxHeight = CGFloat(50 + contactsState.getContactsBySearch(search: advancedCommand).count * 55)
            })
        
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        // TODO: make view over window toolbar items, close but should overlay the toolbar items
                        Button("Close") {
                            contactsState.advancedMenuePressed.toggle()
                        }.padding(.trailing, 20).padding(.top, 30)
                    }
                    Spacer()
                    ZStack {
                        GeometryReader { geometryBox in
                            RoundedRectangle(cornerRadius: 15).foregroundColor(Color(red: 250/255, green: 250/255, blue: 250/255))
                        
                        VStack {
                            ZStack {
                                HStack {
                                    if advancedCommand.first == "/" {
                                        Image(systemName: "command").transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.08))).font(.system(size: 18, weight: .medium)).padding(.leading, 18)
                                    } else {
                                        Image(systemName: "magnifyingglass").transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.08))).font(.system(size: 18, weight: .medium)).padding(.leading, 18)
                                    }
                                    TextField("Enter for search or use / for a command", text: binding).font(.system(size: 18, weight: .medium)).frame(height: 50).font(.title).textFieldStyle(PlainTextFieldStyle()).padding(.trailing, 10)
                                }
                            }
                            Group {
                                ForEach(contactsState.getContactsBySearch(search: advancedCommand), id: \.self) { contact in
                                    AdvancedMenuRow(contact: contact, isHovered: false).padding(.leading, 10).padding(.trailing, 10).padding(.top, -5).padding(.bottom, -5)
                                }
                            }
                        }
                        }
                    }.frame(width: 450, height: self.boxHeight).padding(.bottom, geoBox)
                    Spacer()
                }.zIndex(1).frame(width: geometry.size.width, height: geometry.size.height).background(Color.white).opacity(0.97)
            }
        }
    }
}

struct AdvancedMenuRow: View {
    @State var contact: Contact
    @State var isHovered : Bool
    
    var body: some View {
        HStack {
            Text(contact.firstname).font(.system(size: 18, weight: .medium))
            Text(contact.lastname).font(.system(size: 18, weight: .medium))
            Spacer()
            if isHovered {
                Text("Use with").font(.system(size: 14, weight: .medium))
                Image(systemName: "return").font(.system(size: 14, weight: .medium))
                Text("or").font(.system(size: 14, weight: .medium))
                Image(systemName: "cursorarrow.rays").font(.system(size: 14, weight: .medium))
            }
            //This Line Is A Fix For Weird Padding Behavior in SwiftUI
            Image(systemName: "cursorarrow.rays").font(.system(size: 14, weight: .medium)).opacity(0).padding(.trailing, -15)
        }.padding(.top, 0).padding(.bottom, 0).frame(height: 50).font(.system(size: 18, weight: .medium)).font(.title).padding(.leading, 5).padding(.trailing, 5).background(isHovered ? Color(red: 240/255, green: 240/255, blue: 240/255) : Color.red.opacity(0)).cornerRadius(10).onHover { (isHovered) in
            self.isHovered = isHovered
        }
    }
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}

struct ContactAddView: View {
 
    
    //CoreData stack for ContactDetail
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var contactsDetail: FetchedResults<ContactDetail>

    @EnvironmentObject var contactsState: ContactsState
    @EnvironmentObject var authState: AuthState
    let gray = Color(red: 207/255, green: 207/255, blue: 212/255)
    let lightGray = Color(red: 240/255, green: 240/255, blue: 240/255)
    @State var firstname = String()
    @State var lastname = String()
    @State var email = String()
    @State var telephone = String()
    @State var birthday = String()
    @State var birthDate = Date()
    @State var selected = false
    @State var hoverRow = false
    
    @State var contactData = ["first_name": "", "last_name": "", "phone": "", "email": "", "dob": "", "note": ""]

    
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
//                                print("Phone: \(phone)")
//                                print("Email: \(email)")
//                                print("Note: \(note)")
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
                            // TODO: save new contact function
                            //HERE
                            contactData["dob"] = String(Int(birthDate.timeIntervalSince1970*1000)) // d.o.b in epoch
                            self.contactsState.createContactCD(contactData: contactData,contactsDetail: contactsDetail ,viewContext: viewContext)
//                            self.contactsState.addContact(firstname: self.contactData["first_name"]!, lastname: self.contactData["last_name"]!, email: self.contactData["email"]!, telephone: self.contactData["phone"]!, birthday: self.birthDate.toString(dateFormat: "dd.MM.yyyy"), company: "")
                          
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

struct ChimpTextField: View {
    @Namespace var chimpTextField
    let placeholder: String
    @Binding var value: String
    @State var animateTextField = false
    var body: some View {
        GeometryReader { geometryTextfield in
            VStack(alignment: .leading) {
                if animateTextField {
                    Text(self.placeholder).font(.system(size: 10)).padding(.bottom, -8).foregroundColor(Color.gray).matchedGeometryEffect(id: "GeoHeadline", in: self.chimpTextField).onTapGesture {
                        }
                } else {
                    Text("")
                }
                ZStack(alignment: .leading) {
                    if !animateTextField {
                        withAnimation(.spring()) {
                            Text(self.placeholder).padding(.bottom, -8).foregroundColor(Color.gray).matchedGeometryEffect(id: "GeoHeadline", in: self.chimpTextField)
                        }
                    }
                    TextField("", text: self.$value)
                        .onChange(of: value) { _ in
                            withAnimation(.spring()) {
                                if value == "" {
                                    animateTextField = false
                                } else {
                                    animateTextField = true
                                }
                            }
                        }
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.bottom, -5)
                        .matchedGeometryEffect(id: "geoHeadline", in: chimpTextField)
                }
                Rectangle().foregroundColor(Color.gray).frame(width: geometryTextfield.size.width, height: 0.5)
            }.padding(.bottom, -8)
        }
    }
}
