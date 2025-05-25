import Foundation

public typealias SnippetList = [UUID: Snippet]

extension SnippetList {
    // MARK: - Initializers
    
    /// Initializes a snippet list from an array of snippets.
    ///
    /// if a duplicate ID is present, only the last snippet with this ID will be in the returned list.
    ///
    /// - parameters:
    ///     - array: the array of snippets.
    init(from array: [Snippet]) {
        self = .init(minimumCapacity: array.count)
        array.forEach { self[$0.id] = $0 }
    }

    // MARK: - member functions
    
    /// Test whether the list contains a snippets with the given ID.
    ///
    /// - parameters:
    ///     - id: The snippet ID.
    ///
    /// - returns:
    ///     - true if and only if the list contains the snippet with the given ID.
    public func contains(id: UUID) -> Bool {
        return self.keys.contains(id)
    }
    
    /// Get the snippets belonging to a given group.
    ///
    /// - parameters:
    ///     - groupID: the group ID.
    ///
    /// - returns: The list of snippets belonging to the group.
    public func snippetsOf(group groupID: UUID) -> Self {
        return self.filter { uuid, snippet in
            return snippet.groupID == groupID
        }
    }
}

// MARK: - Sample data

public extension SnippetList {
    /// A sample list of snippets with no groups.
    static let sample = SnippetList(
        from: [
            Snippet(trigger: "!em1", content: "first@example.com", description: "First email address"),
            Snippet(trigger: "!em2", content: "second@example.com", description: "Second email address"),
            Snippet(trigger: "!em3", content: "third@example.com", description: "Third email address"),
            Snippet(trigger: "!em4", content: "fourth@example.com", description: "Fourth email address"),
            Snippet(trigger: "!em5", content: "fifth@example.com", description: "Fifth email address"),
        ]
    )
}
