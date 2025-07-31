import Foundation

/// A structure representing a snippet group
public struct Group: Codable, Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var description: String?
    
    public init(id: UUID = .init(), name: String, description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
    }
}
