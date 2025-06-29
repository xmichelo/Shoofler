import Foundation
import SwiftUI
import UniformTypeIdentifiers

/// Structure for snippets.
public struct Snippet: Equatable, Codable, Identifiable, Hashable, Sendable {
    /// The snippet ID.
    public let id: UUID
    
    /// The trigger for the snippet.
    public var trigger: String
    
    /// The content of the snippet.
    public var content: String
    
    /// The optional description of the Snippet.
    public var description: String? = nil
    
    /// The optional group of the snipppet.
    public var groupID: UUID? = nil

    /// Creates a snippet.
    ///
    /// - parameters:
    ///     - id: the snippet ID. If none is provided, a new random UUID is used.
    ///     - trigger: the trigger for the snippet.
    ///     - content: the content of the snippet.
    ///     - description: the optional description of the snippet.
    ///     - group: the optional group of the snippet.
    public init(id: UUID = UUID(), trigger: String, content: String, description: String? = nil, group: UUID? = nil) {
        self.id = id
        self.trigger = trigger
        self.content = content
        self.description = description
        self.groupID = group
    }
}

// Implement Uniform Type Identifier for Transferable
extension UTType {
    static var snippet: UTType { UTType(exportedAs: "app.shoofler.Snippet") }
}

// Implementing Transferable is required to implement Drag & Drop.
extension Snippet: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .snippet)
        ProxyRepresentation { (snippet: Snippet) in
            snippet.trigger
        }
    }
}
