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
    
    init(buttonSize: ChimpButtonCases, isPressed: Binding<Bool>, buttonText: String) {
        self._isPressed = isPressed
        self.buttonText = buttonText
        switch buttonSize {
        case .ButtonLG:
            self.selectedSize = 200.0
            self.selectedWidth = 100.0
        case .ButtonMD:
            self.selectedSize = 100.0
            self.selectedWidth = 50
        case .ButtonSM:
            self.selectedSize = 50.0
            self.selectedWidth = 25.0
            
        }
    }
    
    
    
    var body: some View {
        ZStack{
            Text(buttonText).zIndex(1)
            RoundedRectangle(cornerRadius: 25)
                .frame(width: self.selectedSize, height: self.selectedWidth)
                .foregroundColor(Color.red)
                .zIndex(0)
        }
        
    }
}


enum ChimpButtonCases {
    case ButtonLG
    case ButtonMD
    case ButtonSM
}
