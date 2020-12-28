import SwiftUI

struct Project: Identifiable, Hashable, Equatable {
    var id = UUID()
    var name: String
    var progress: Int
}
