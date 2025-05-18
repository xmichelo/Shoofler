import Foundation

/// A structure representing a snippet group
struct Group: Codable, Identifiable {
    /// The ID of the group.
    var id: UUID
    
    /// The name of the group.
    var name: String
    
    /// The optional description of the group.
    var description: String?
    
    /// Creates a group.
    init(id: UUID = .init(), name: String, description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
    }
}
