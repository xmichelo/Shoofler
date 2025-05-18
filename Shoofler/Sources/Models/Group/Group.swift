import Foundation

struct Group: Codable, Identifiable {
    var id: UUID
    var name: String
    var description: String?
    
    init(id: UUID = .init(), name: String, description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
    }
}
