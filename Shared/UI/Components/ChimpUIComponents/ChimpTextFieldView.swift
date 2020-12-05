import SwiftUI

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
