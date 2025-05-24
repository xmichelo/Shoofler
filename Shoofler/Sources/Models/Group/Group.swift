import Foundation

/// A structure representing a snippet group
public struct Group: Codable, Identifiable {
    /// The ID of the group.
    public var id: UUID
    
    /// The name of the group.
    public var name: String
    
    /// The optional description of the group.
    public var description: String?
    
    /// Creates a group.
    ///
    /// - Parameters:
    ///     - id: the group ID.
    ///     - name: the group name.
    ///     - description: the group description.
    public init(id: UUID = .init(), name: String, description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
    }
}
