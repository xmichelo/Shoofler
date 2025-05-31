import Foundation

public typealias GroupList = [Group]

public extension GroupList {
    // MARK: - Sample data
    
    /// A sample group list.
    static let sample: GroupList = [
        Group(id: UUID(), name: "Professional", description: "A group containing Professional snippets."),
        Group(id: UUID(), name: "Personal", description: "A group with personal snippets."),
        Group(id: UUID(), name: "Emojis", description: "A group containing emoji related snippets.")
    ]
}
