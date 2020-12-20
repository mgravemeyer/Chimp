import SwiftUI

struct ContactDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var contactsState: ContactsState
    var contact: Contact
    
        var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                HStack {
                    Text(contact.firstname).font(.system(size: 30)).fontWeight(.light).lineLimit(1)
                    Text(contact.lastname).font(.system(size: 30)).fontWeight(.bold).lineLimit(1)
                    Spacer()
                    Button("Add Contact") {
                        contactsState.pressAddMenue()
                    }
                }.padding(.bottom, 20)
                ContactsDetailContactRow(selectedContact: contact)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 10)
                    ContactsDetailTagRow(selectedContact: contact).padding(.bottom, 12)
                HStack {
                    Spacer()
                    ContactsDetailRadioSection()
                    Spacer()
                }
                Spacer()
            }.zIndex(1)
            Rectangle().foregroundColor(colorScheme == .dark ? Color.chimpDarkBackground : Color.chimpLightBackground).zIndex(0)
        }.padding(.bottom, 20).padding(.trailing, 20).padding(.top, 40)
    }
}

struct ContactDetailView_Previews : PreviewProvider {
    static var previews: some View {
        CoreDataService.shared.changeToDevelopmentMode()
        return ContactDetailView(contact: Contact(firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", telephone: "123456789", birthday: "12.12.2001", company: "Chimp"))
            .environmentObject(ContactsState())
    }
}

struct ContactsDetailContactRow: View {
    var selectedContact: Contact
    var body: some View {
        HStack {
            Button(action: {
                NSWorkspace.shared.open(URL(string: "mailto:\(selectedContact.email)")!)
            }, label: {
                HStack {
                    Image(systemName: "envelope").foregroundColor(Color.chimpPrimary)
                    Text(selectedContact.email).foregroundColor(Color.chimpLightText).padding(.leading, -5)
                }
            })
            Button(action: {
                NSWorkspace.shared.open(URL(string: "tel://\(selectedContact.telephone)")!)
            }, label: {
                HStack {
                    Image(systemName: "phone").foregroundColor(Color.chimpPrimary)
                    Text(selectedContact.telephone).foregroundColor(Color.chimpLightText).padding(.leading, -5)
                }
            })
        }
    }
}

struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)

        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}

struct ContactsDetailRadioSection: View {
    @State var selection = "Notes"
    var corner = CGFloat(10)
    var body: some View {
        HStack {
            Button(action: {
                
            }, label: {
                ZStack {
                    Text("Notes").zIndex(1).foregroundColor(Color.white)
                    RoundedCorners(tl: 10, tr: 0, bl: 10, br: 0).foregroundColor(Color.gray)
                }
            }).buttonStyle(PlainButtonStyle()).frame(height: 25).offset(x: 10)
            Button(action: {
                
            }, label: {
                ZStack {
                    Text("E-Mails").zIndex(1).foregroundColor(Color.white)
                    RoundedCorners(tl: 0, tr: 0, bl: 0, br: 0).foregroundColor(Color.gray)
                }
            }).buttonStyle(PlainButtonStyle()).frame(height: 25)
            Button(action: {
                
            }, label: {
                ZStack {
                    Text("Calls").zIndex(1).foregroundColor(Color.white)
                    RoundedCorners(tl: 0, tr: 10, bl: 0, br: 10).foregroundColor(Color.gray)
                }
            }).buttonStyle(PlainButtonStyle()).frame(height: 25).offset(x: -10)
        }.frame(width: 200)
    }
}

struct ContactsDetailInformation: View {
    var selectedContact: Contact
    var body: some View {
        HStack {
            Text("🎂 \(selectedContact.birthday)")
            Text("🏢 \(selectedContact.company)")
        }
    }
}

struct ContactsDetailTagRow: View {
    var selectedContact: Contact
    var body: some View {
        HStack {
            TagView(tagText: "Tag One")
            TagView(tagText: "Tag Two")
        }
    }
}
