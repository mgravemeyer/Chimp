import SwiftUI

struct CommandLineView: View {
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
                                    CommandLineRowView(contact: contact, isHovered: false).padding(.leading, 10).padding(.trailing, 10).padding(.top, -5).padding(.bottom, -5)
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

#if DEBUG
struct CommandLineView_Previews : PreviewProvider {
    @ObservedObject static var contactsState = ContactsState()
    static var previews: some View {
        CommandLineView(advancedCommand: "thisIsAVeryLongAdvancedCommandThatIsSadlyToo LongTogettingDisplayed").environmentObject(contactsState)
    }
}
#endif
