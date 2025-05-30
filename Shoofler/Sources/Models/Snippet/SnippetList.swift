import Foundation

public typealias SnippetList = [Snippet]


public extension SnippetList {
    // MARK: - member functions

    /// Get the snippets belonging to a given group.
    ///
    /// - parameters:
    ///     - groupID: the group ID.
    ///
    /// - returns: The list of snippets belonging to the group.
    func snippetsOf(group groupID: UUID) -> SnippetList {
        return self.filter { $0.groupID == groupID }
    }
}

public extension SnippetList {
    // MARK: - Sample data

    /// A sample list of snippets with no groups.
    static let sample: SnippetList = [
            Snippet(trigger: "!em1", content: "first@example.com", description: "First email address"),
            Snippet(trigger: "!em2", content: "second@example.com", description: "Second email address"),
            Snippet(trigger: "!em3", content: "third@example.com", description: "Third email address"),
            Snippet(trigger: "!em4", content: "fourth@example.com", description: "Fourth email address"),
            Snippet(trigger: "!em5", content: "fifth@example.com", description: "Fifth email address"),
        ]
}
