//
//  ChimpPrimaryButton.swift
//  Chimp
//
//  Created by Sean on 20.11.20.
//

import SwiftUI

struct ChimpPrimaryButton: View {
    
    var selectedSize: CGFloat
    var selectedWidth: CGFloat
    @Binding var isPressed: Bool
    var buttonText: String
    @State var isHovered = Bool()
    
    init(buttonSize: ChimpButtonCases, isPressed: Binding<Bool>, buttonText: String) {
        self._isPressed = isPressed
        self.buttonText = buttonText
        switch buttonSize {
        case .ButtonLG:
            self.selectedSize = 100.0
            self.selectedWidth = 50.0
        case .ButtonMD:
            self.selectedSize = 50.0
            self.selectedWidth = 25.0
 
        }
    }
    
    
    
    var body: some View {
        ZStack{
            Text(buttonText).zIndex(1)
            RoundedRectangle(cornerRadius: 25)
                .frame(width: self.selectedSize, height: self.selectedWidth)
                .zIndex(0)
                .foregroundColor(isHovered ? Color(red: 240/255, green: 240/255, blue: 240/255) : Color(red: 27/255, green:7/255, blue: 242/255))
                .onHover { (isHovered) in
                    self.isHovered = isHovered
                }
        }
        
    }
}


enum ChimpButtonCases {
    case ButtonLG
    case ButtonMD

}
