import SwiftUI

struct PreviewCoreDataWrapper<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content()
        CoreDataManager.shared.changeToDevelopmentMode()
        }
  var body: some View {
    content
  }
}
