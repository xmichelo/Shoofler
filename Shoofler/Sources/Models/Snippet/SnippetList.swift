import Foundation

public typealias SnippetList = [Snippet]

extension SnippetList {
    // MARK: - member functions
    
    /// Test whether the list contains a snippets with the given ID.
    ///
    /// - parameters:
    ///     - id: The snippet ID.
    ///
    /// - returns:
    ///     - true if and only if the list contains the snippet with the given ID.
    public func contains(id: UUID) -> Bool {
        return self.contains { $0.id == id }
    }
    
    /// Get the snippets belonging to a given group.
    ///
    /// - parameters:
    ///     - groupID: the group ID.
    ///
    /// - returns: The list of snippets belonging to the group.
    public func snippetsOf(group groupID: UUID) -> SnippetList {
        return self.filter { $0.groupID == groupID }
    }

    /// Return a sanitized version of the list.
    ///
    /// Only the first snippet with a given UUID is kept.
    ///
    /// - Returns: The sanitized list.
    public func sanitized() -> SnippetList {
        var uuids: Set<UUID> = []
        return self.filter { snippet in
            if uuids.contains(snippet.id) {
                return false
            }
            uuids.insert(snippet.id)
            return true
        }
    }
    
    /// Subscript based on snippet ID
    ///
    /// - Parameters:
    ///     - id The ID of the snippet.
    ///
    /// - Returns: The first snippet in the list with the given ID.
    subscript (id: UUID) -> Snippet? {
        return self.first(where: { $0.id == id })
    }
}

// MARK: - Sample data

public extension SnippetList {
    /// A sample list of snippets with no groups.
    static let sample: SnippetList = [
            Snippet(trigger: "!em1", content: "first@example.com", description: "First email address"),
            Snippet(trigger: "!em2", content: "second@example.com", description: "Second email address"),
            Snippet(trigger: "!em3", content: "third@example.com", description: "Third email address"),
            Snippet(trigger: "!em4", content: "fourth@example.com", description: "Fourth email address"),
            Snippet(trigger: "!em5", content: "fifth@example.com", description: "Fifth email address"),
        ]
}
