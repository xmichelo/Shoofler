import Foundation

public typealias GroupList = [Group]

public extension GroupList {
    // MARK: - Sample data
    
    /// A sample group list.
    static let sample: GroupList = [
        Group(id: UUID(), name: "First Group", description: "First group"),
        Group(id: UUID(), name: "Second Group", description: "Second group"),
        Group(id: UUID(), name: "Third Group"),
    ]
}
