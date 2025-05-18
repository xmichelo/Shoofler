import Foundation

typealias SnippetList = [UUID: Snippet]

extension SnippetList {
    static var sample: SnippetList {
        var snippetList = SnippetList()
        snippetList.add(Snippet(id: UUID(), trigger: "!em1", snippet: "first@example.com", description: "First email address"))
        snippetList.add(Snippet(id: UUID(), trigger: "!em2", snippet: "second@example.com", description: "Second email address"))
        snippetList.add(Snippet(id: UUID(), trigger: "!em3", snippet: "third@example.com", description: "Third email address"))
        snippetList.add(Snippet(id: UUID(), trigger: "!em4", snippet: "fourth@example.com", description: "Fourth email address"))
        snippetList.add(Snippet(id: UUID(), trigger: "!em5", snippet: "fifth@example.com", description: "Fifth email address"))
        return snippetList
    }
    
    /// Initalizer that use an array of snippet to initialize the ``SnippetList``.
    ///
    /// - Parameters:
    ///     - snippets: The array of snippets.
    init(snippets: [Snippet]) {
        self.init()
        snippets.forEach { snippet in
            self[snippet.id] = snippet
        }
    }
    
    mutating func add(_ snippet: Snippet) {
        self[snippet.id] = snippet
    }
}
