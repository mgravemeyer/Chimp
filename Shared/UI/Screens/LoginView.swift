import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authState: AuthState
    @State var email = String()
    @State var password = String()
    @State var error = String()
    @State var isPressed = false
    var body: some View {
        HStack {
            Group {
                Image("Login_Background").resizable().frame(width: 500, height: 600)
            }.frame(width: 500, height: 600)
            Group {
                VStack {
                    Text("Chimp")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .padding(.bottom, 8)
                    HStack{
                        Text("All your tasks, projects and contacts")
                            .font(.system(size: 14.0)).fontWeight(.light)
                        Text("in one place. ")
                            .font(.system(size: 14.0)).fontWeight(.bold)
                    }.padding(.bottom, 16)
                    Group {
                        TextField("Username", text: self.$email).textFieldStyle(PlainTextFieldStyle()).padding(.bottom, 5)
                        SecureField("Password", text: self.$password).textFieldStyle(PlainTextFieldStyle()).padding(.bottom, 5)
                    }.frame(width: 260).padding(.bottom, 8)
                    VStack {
                        ChimpPrimaryButton(buttonSize: .buttonMd, buttonColor: .chimpSecondary, isPressed: self.$isPressed, buttonText: "Sign In").onTapGesture {
                            self.authState.authUser(email: email, password: password, option: .signIn)
                        }.accessibility(identifier: "ChimpButton").padding(.bottom, 4)

                        ChimpPrimaryButton(buttonSize: .buttonMd, buttonColor: .chimpPrimary, isPressed: self.$isPressed, buttonText: "Sign Up").onTapGesture {
                            self.authState.authUser(email: email, password: password, option: .signUp)
                        }
                        if error != "" {
                            Text(self.error)
                                .fontWeight(.semibold)
                            frame(minWidth: 230)
                                .foregroundColor(Color.red)
                        }
                    }.frame(width: 260)
                }.frame(width: 350)
            }.frame(width: 500, height: 600).padding(.bottom, 70)
        }.frame(width: 1000, height: 600).background(Color.white)
    }
}

#if DEBUG
struct LoginView_Previews : PreviewProvider {
    static var previews: some View {
        return VStack {
            LoginView(
                email: "",
                password: ""
            )
            LoginView(
                email: "veryLongEmailIsVeryLongForTheTestForUli@web.de",
                password: "thisIsAVeryveryLongPasswordThatIsGetingTestd"
            ).environmentObject(AuthState())
        }
    }
}
#endif
