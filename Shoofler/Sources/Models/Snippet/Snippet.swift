import Foundation

/// Structure for snippets.
public struct Snippet: Codable, Identifiable {
    /// The snippet ID.
    public let id: UUID
    
    /// The trigger for the snippet.
    public var trigger: String
    
    /// The content of the snippet.
    public var snippet: String
    
    /// The optional description of the Snippet.
    public var description: String? = nil
    
    /// The optional group of the snipppet.
    public var groupID: UUID? = nil

    /// Creates a snippet.
    ///
    /// - parameters:
    ///     - id: the snippet ID. If none is provided, a new random UUID is used.
    ///     - trigger: the trigger for the snippet.
    ///     - snippet: the content of the snippet.
    ///     - description: the optional description of the snippet.
    ///     - group: the optional group of the snippet.
    public init(id: UUID = UUID(), trigger: String, snippet: String, description: String? = nil, group: UUID? = nil) {
        self.id = id
        self.trigger = trigger
        self.snippet = snippet
        self.description = description
        self.groupID = group
    }
}
