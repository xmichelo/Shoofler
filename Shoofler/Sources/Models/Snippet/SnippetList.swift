import Foundation

/// A type alias for lists of snippets.
typealias SnippetList = [Snippet]

extension SnippetList {
    /// A sample list of snippets with no groups.
    static let sample = [
        Snippet(id: UUID(), trigger: "!em1", snippet: "first@example.com", description: "First email address"),
        Snippet(id: UUID(), trigger: "!em2", snippet: "second@example.com", description: "Second email address"),
        Snippet(id: UUID(), trigger: "!em3", snippet: "third@example.com", description: "Third email address"),
        Snippet(id: UUID(), trigger: "!em4", snippet: "fourth@example.com", description: "Fourth email address"),
        Snippet(id: UUID(), trigger: "!em5", snippet: "fifth@example.com", description: "Fifth email address"),
    ]
    
    /// Checks if a snippet is present in the list, based on its ID.
    ///
    /// - parameters: id The ID of the snippet.
    ///
    /// - returns; true if and only if the snippet is in the list
    func contains(id: UUID) -> Bool {
        return self.contains { $0.id == id }
    }
    
    /// Adds or replaces a snippet to the list.
    ///
    /// - parameters;
    ///     - snippet: The snippet to add or modify.
    mutating func add(_ snippet: Snippet) {
        if let i = self.firstIndex(where: { $0.id == snippet.id }) {
            self[i] = snippet
        } else {
            append(snippet)
        }
    }
    
    /// Get the snippets belonging to a given group.
    ///
    /// - parameters:
    ///     - groupID: the group ID.
    ///
    /// - returns: The list of snippets belonging to the group.
    func snippetsOf(groupID: UUID) -> SnippetList {
        return self.filter { $0.groupID == groupID }
    }
}
