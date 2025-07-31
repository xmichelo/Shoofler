import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct Snippet: Equatable, Codable, Identifiable, Hashable, Sendable {
    public let id: UUID
    public var trigger: String
    public var content: String
    public var description: String? = nil
    public var groupID: UUID? = nil

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
