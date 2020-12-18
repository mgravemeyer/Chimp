import SwiftUI

struct LoadingView: View {
    var body: some View {
        HStack{
            Text("Loading...")
        }.frame(width: 1000, height: 600).background(Color.white)
    }
}

#if DEBUG
struct LoadingView_Previews : PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
#endif
