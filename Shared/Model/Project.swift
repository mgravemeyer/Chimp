import SwiftUI

struct Project: Identifiable, Hashable, Equatable {
    var id = UUID()
    var name: String
    var start: String
    var end: String
    var clients: [UUID]
    var progress: Int
    var notes: String
}
