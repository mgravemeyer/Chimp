import SwiftUI

struct ChimpPrimaryButton: View {
    
    enum ChimpButtonSize {
        case buttonLg
        case buttonMd
    }
    
    enum ChimpButtonColor {
        case chimpPrimary
        case chimpSecondary
    }
    
    var selectedHeight: CGFloat
    var selectedWidth: CGFloat
    @Binding var isPressed: Bool
    var buttonText: String
    @State var isHovered = Bool()
    
    var btnColor:Color
    var btnHoverColor: Color
    var textColor: Color
    var textHoverColor: Color
    
    init(buttonSize: ChimpButtonSize, buttonColor: ChimpButtonColor ,isPressed: Binding<Bool>, buttonText: String) {
        self._isPressed = isPressed
        self.buttonText = buttonText
        switch buttonSize {
        case .buttonLg:
            self.selectedHeight = 20.0
            self.selectedWidth = 70.0
        case .buttonMd:
            self.selectedHeight = 28.0
            self.selectedWidth = 70.0
        }
        switch buttonColor {
        case .chimpPrimary:
            self.btnColor = Color.chimpPrimary
            self.btnHoverColor = Color.chimpSecondary
            self.textColor = Color.chimpSecondary
            self.textHoverColor = Color.chimpPrimary
        case .chimpSecondary:
            self.btnColor = Color.chimpSecondary
            self.btnHoverColor = Color.chimpPrimary
            self.textColor = Color.chimpPrimary
            self.textHoverColor = Color.chimpSecondary
        }
    }
    var body: some View {
        ZStack{
            Text(buttonText).foregroundColor(isHovered ? textHoverColor : textColor).zIndex(1)
            RoundedRectangle(cornerRadius: 10)
                .shadow(color: Color(red: 217/255, green: 217/255, blue: 217/255), radius: 0.8, x: 0.4, y: 0)
                .frame(width: self.selectedWidth, height: self.selectedHeight)
                .zIndex(0)
                .foregroundColor(isHovered ? btnHoverColor : btnColor)
                .onHover { (isHovered) in
                    self.isHovered = isHovered
                }
        }
    }
}

#if DEBUG
struct ChimpPrimaryButton_Previews : PreviewProvider {
    @State static var isNotPressed = false
    @State static var isPressed = false
    static var previews: some View {
        return VStack {
            ChimpPrimaryButton(buttonSize: .buttonLg, buttonColor: .chimpPrimary, isPressed: $isNotPressed, buttonText: "some text too long")
            ChimpPrimaryButton(buttonSize: .buttonLg, buttonColor: .chimpSecondary, isPressed: $isNotPressed, buttonText: "some text")
            ChimpPrimaryButton(buttonSize: .buttonLg, buttonColor: .chimpPrimary, isPressed: $isPressed, buttonText: "some text")
        }
    }
}
#endif
