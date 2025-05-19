import Foundation

/// A structure storing a list of snippets.
struct SnippetList: Codable, Copyable {
    typealias Index = Int
    
    /// The array storing the snippets
    private var array: [Snippet]

    /// Initialize the list from an array of snippets.
    ///
    /// - parameters:
    ///     - array: the array of snippets to initialize the list with.
    init(from array: [Snippet] = []) {
        self.array = array
    }

    /// A copy of the array used internally to store the snippet list.
    var internalArray: [Snippet] {
        array
    }
    
    /// Test whether the list contains a snippets with the given UUID.
    ///
    /// - parameters
    ///
    func contains(id: UUID) -> Bool {
        return self.contains(where: { $0.id == id })
    }
    
    /// Returns a snippet list containing, in order, the elements of the list that satisfy the given predicate.
    ///
    /// - parameters:
    ///     - isIncluded: the predicate
    /// - returns: an array of the elements that `isIncluded` allowed.
    func filter(_ isIncluded: (Snippet) -> Bool) -> SnippetList {
        return SnippetList(from: array.filter(isIncluded))
    }

    /// Adds or replaces a snippet to the list.
    ///
    /// - parameters;
    ///     - snippet: The snippet to add or modify.
    mutating func add(_ snippet: Snippet) {
        if let i = self.firstIndex(where: { $0.id == snippet.id }) {
            array[i] = snippet
        } else {
            array.append(snippet)
        }
    }
    
    /// Get the snippets belonging to a given group.
    ///
    /// - parameters:
    ///     - groupID: the group ID.
    /// - return true if and only a snippet with the given UUID exists in the list.
    ///
    /// - returns: The list of snippets belonging to the group.
    func snippetsOf(groupID: UUID) -> SnippetList {
        return self.filter { $0.groupID == groupID }
    }
}

extension SnippetList: BidirectionalCollection {
    /// The start index of the sequence
    var startIndex: Int {
        return array.startIndex
    }
    
    /// The end index of the sequence
    var endIndex: Int {
        return array.endIndex
    }

    /// Returns the index of the element after the element at index `i`.
    ///
    /// - parameters:
    ///     - i: the index
    ///
    /// - returns: the index of the element after `ì`.
    func index(after i: Int) -> Int {
        return array.index(after: i)
    }
    
    /// Returns the index of the element after the element at index `i`.
    ///
    /// - parameters:
    ///     - i: the index
    ///
    /// - returns: the index of the element before `ì`.
    func index(before i: Int) -> Int {
        return array.index(before: i)
    }

    /// Access the element of the snippet list at the given index.
    ///
    /// - parameters:
    ///     - index: The index of the snippet.
    /// - returns:
    ///     - The snippet at the given index.
    subscript(_ index: Int) -> Snippet {
        get {
            return array[index]
        }
        set(newValue) {
            array[index] = newValue
        }
    }
}

extension SnippetList {
    /// A sample list of snippets with no groups.
    static let sample = SnippetList(
        from: [
            Snippet(id: UUID(), trigger: "!em1", snippet: "first@example.com", description: "First email address"),
            Snippet(id: UUID(), trigger: "!em2", snippet: "second@example.com", description: "Second email address"),
            Snippet(id: UUID(), trigger: "!em3", snippet: "third@example.com", description: "Third email address"),
            Snippet(id: UUID(), trigger: "!em4", snippet: "fourth@example.com", description: "Fourth email address"),
            Snippet(id: UUID(), trigger: "!em5", snippet: "fifth@example.com", description: "Fifth email address"),
        ]
    )
}
