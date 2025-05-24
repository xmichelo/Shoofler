import Foundation

/// A structure storing a list of snippets.
public struct SnippetList: Codable, Copyable {
    // MARK: - type aliases
    
    public typealias Index = Int
    
    // MARK: - Stored properties
    
    /// The array storing the snippets
    private var snippets: [Snippet] = []

    // MARK: - Static factory functions
    
    /// Creates a snippet list from an array of snippets.
    ///
    /// if a duplicate ID is present, only the last snippet with this ID will be in the returned list.
    ///
    /// - parameters:
    ///     - array: the array of snippets.
    ///
    /// - returns: The snippet list build using the snippets in array.
    static func from(array: [Snippet]) -> SnippetList {
        var result = SnippetList()
        result.snippets.reserveCapacity(array.count)
        array.forEach { result.add($0) }
        return result
    }

    // MARK: - member functions
    
    /// Test whether the list contains a snippets with the given UUID.
    ///
    /// - parameters
    ///
    public func contains(id: UUID) -> Bool {
        return self.contains(where: { $0.id == id })
    }
    
    /// Returns a snippet list containing, in order, the elements of the list that satisfy the given predicate.
    ///
    /// - parameters:
    ///     - isIncluded: the predicate
    /// - returns: an array of the elements that `isIncluded` allowed.
    public func filter(_ isIncluded: (Snippet) -> Bool) -> SnippetList {
        return SnippetList.from(array: snippets.filter(isIncluded))
    }

    /// Adds or replaces a snippet to the list.
    ///
    /// - parameters;
    ///     - snippet: The snippet to add or modify.
    public mutating func add(_ snippet: Snippet) {
        if let i = self.firstIndex(where: { $0.id == snippet.id }) {
            snippets[i] = snippet
        } else {
            snippets.append(snippet)
        }
    }
    
    /// Get the snippets belonging to a given group.
    ///
    /// - parameters:
    ///     - groupID: the group ID.
    /// - return true if and only a snippet with the given UUID exists in the list.
    ///
    /// - returns: The list of snippets belonging to the group.
    public func snippetsOf(groupID: UUID) -> SnippetList {
        return self.filter { $0.groupID == groupID }
    }
}

// MARK: - BidirectionalCollection

extension SnippetList: BidirectionalCollection {
    /// The start index of the sequence
    public var startIndex: Int {
        return snippets.startIndex
    }
    
    /// The end index of the sequence
    public var endIndex: Int {
        return snippets.endIndex
    }

    /// Returns the index of the element after the element at index `i`.
    ///
    /// - parameters:
    ///     - i: the index
    ///
    /// - returns: the index of the element after `ì`.
    public func index(after i: Int) -> Int {
        return snippets.index(after: i)
    }
    
    /// Returns the index of the element after the element at index `i`.
    ///
    /// - parameters:
    ///     - i: the index
    ///
    /// - returns: the index of the element before `ì`.
    public func index(before i: Int) -> Int {
        return snippets.index(before: i)
    }

    /// Access the element of the snippet list at the given index.
    ///
    /// - parameters:
    ///     - index: The index of the snippet.
    /// - returns:
    ///     - The snippet at the given index.
    public subscript(_ index: Int) -> Snippet {
        get {
            return snippets[index]
        }
        set(newValue) {
            snippets[index] = newValue
        }
    }
}

// MARK: - Sample data

public extension SnippetList {
    /// A sample list of snippets with no groups.
    static let sample = SnippetList.from(
        array: [
            Snippet(trigger: "!em1", snippet: "first@example.com", description: "First email address"),
            Snippet(trigger: "!em2", snippet: "second@example.com", description: "Second email address"),
            Snippet(trigger: "!em3", snippet: "third@example.com", description: "Third email address"),
            Snippet(trigger: "!em4", snippet: "fourth@example.com", description: "Fourth email address"),
            Snippet(trigger: "!em5", snippet: "fifth@example.com", description: "Fifth email address"),
        ]
    )
}
