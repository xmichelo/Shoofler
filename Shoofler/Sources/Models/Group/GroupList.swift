import Foundation

public typealias GroupList = [Group]

public extension GroupList {
    // MARK: - Sample data
    
    /// A sample group list.
    static let sample: GroupList = [
        Group(id: UUID(0), name: "Professional", description: "A group containing Professional snippets."),
        Group(id: UUID(1), name: "Personal", description: "A group with personal snippets."),
        Group(id: UUID(2), name: "Emojis", description: "A group containing emoji related snippets.")
    ]
}
