import Foundation
import ComposableArchitecture

public typealias SnippetList = IdentifiedArrayOf<Snippet>

let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

public extension SnippetList {
    // MARK: - member functions
    
    /// Get the snippets belonging to a given group.
    ///
    /// - parameters:
    ///     - groupID: the group ID.
    ///
    /// - returns: The list of snippets belonging to the group.
    func snippetsOf(group: Group) -> SnippetList {
        return self.filter { $0.groupID == group.id }
    }
}

public extension SnippetList {
    // MARK: - Sample data
    
    /// A sample list of snippets with no groups.
    static let sample: SnippetList = [
        Snippet(id: UUID(0), trigger: "!em0", content: "address1@example.com", description: "Email address at position 0", group: UUID(0)),
        Snippet(id: UUID(1), trigger: "!em1", content: "address1@example.com", description: "Email address at position 1", group: UUID(0)),
        Snippet(id: UUID(2), trigger: "!em2", content: "address1@example.com", description: "Email address at position 2", group: UUID(1)),
        Snippet(id: UUID(3), trigger: "!em3", content: "address1@example.com", description: "Email address at position 3", group: UUID(2)),
        Snippet(id: UUID(4), trigger: "!em4", content: "address1@example.com", description: "Email address at position 4", group: UUID(2)),
        Snippet(id: UUID(5), trigger: "!em5", content: "address1@example.com", description: "Email address at position 5", group: UUID(0)),
        Snippet(id: UUID(6), trigger: "!em6", content: "address1@example.com", description: "Email address at position 6", group: UUID(0)),
        Snippet(id: UUID(7), trigger: "!em7", content: "address1@example.com", description: "Email address at position 7", group: UUID(0)),
        Snippet(id: UUID(8), trigger: "!em8", content: "address1@example.com", description: "Email address at position 8", group: UUID(0)),
        Snippet(id: UUID(9), trigger: "zzlorem", content: lorem, description: "Lorem ipsum placeholder", group: UUID(0)),
    ]
}
