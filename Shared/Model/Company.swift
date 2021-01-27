import Foundation

struct Company: Identifiable, Hashable, Equatable {
    let id = UUID()
    private(set) var name: String
}
