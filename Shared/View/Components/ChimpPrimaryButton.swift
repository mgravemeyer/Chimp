//
//  ChimpPrimaryButton.swift
//  Chimp
//
//  Created by Sean on 20.11.20.
//

import SwiftUI

struct ChimpPrimaryButton: View {
    enum ChimpButtonSize {
        case buttonLg
        case buttonMd
    }
    
    enum ChimpButtonColor {
        case primary
        case secondary
    }
    
    var selectedSize: CGFloat
    var selectedWidth: CGFloat
    var btnColor:Color
    @Binding var isPressed: Bool
    var buttonText: String
    @State var isHovered = Bool()
    
    init(buttonSize: ChimpButtonSize, buttonColor: ChimpButtonColor ,isPressed: Binding<Bool>, buttonText: String) {
        self._isPressed = isPressed
        self.buttonText = buttonText
        switch buttonSize {
        case .buttonLg:
            self.selectedSize = 100.0
            self.selectedWidth = 50.0
        case .buttonMd:
            self.selectedSize = 75.0
            self.selectedWidth = 35.0
            
        }
        
        switch buttonColor {
        case .primary:
            self.btnColor = Color.primary
        case .secondary:
            self.btnColor = Color.secondary
        }
        
    }
    
    
    
    var body: some View {
        ZStack{
            Text(buttonText).foregroundColor(isHovered ?  Color(red: 27/255, green:7/255, blue: 242/255) : Color.white).zIndex(1)
            RoundedRectangle(cornerRadius: 10)
                .frame(width: self.selectedSize, height: self.selectedWidth)
                .zIndex(0)
                .foregroundColor(btnColor)
                .onHover { (isHovered) in
                    self.isHovered = isHovered
                }
        }
        
    }
}



