import SwiftUI

struct CommandLineRowView: View {
    
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
            Image(systemName: "cursorarrow.rays").font(.system(size: 14, weight: .medium)).opacity(0).padding(.trailing, -15)
        }.padding(.top, 0).padding(.bottom, 0).frame(height: 50).font(.system(size: 18, weight: .medium)).font(.title).padding(.leading, 5).padding(.trailing, 5).background(isHovered ? Color(red: 240/255, green: 240/255, blue: 240/255) : Color.red.opacity(0)).cornerRadius(10).onHover { (isHovered) in
            self.isHovered = isHovered
        }
    }
}

#if DEBUG
struct CommandLineRowView_Previews : PreviewProvider {
    
    static var contact = Contact(id: UUID().uuidString, firstname: "longFirstNameTest", lastname: "longLastNameTest", email: "longEmailTest@web.de", phone: "123456789", dob: "12.12.2001", note: "", company_uids: [], tag_uids: [], project_uids: [])
    static var isHovered = false
    static var previews: some View {
        CommandLineRowView(contact: contact, isHovered: isHovered)
    }
}
#endif
