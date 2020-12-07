import SwiftUI

struct TagView: View {
    
    @State var tagText: String
    
    var body: some View {
        Text(tagText)
            .frame(width: 100, height: 20)
            .foregroundColor(Color.white)
            .background(Color.orange)
            .cornerRadius(10)
    }
}
