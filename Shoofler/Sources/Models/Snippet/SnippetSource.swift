protocol SnippetSource {
    func load() throws -> [Snippet]
    func save(snippets: [Snippet]) throws
}
