import Foundation

struct NavigationCategory: Identifiable, Hashable {
    let id = UUID()
    let symbol: String
    let name: String
    var notification: Int
}
