import Foundation

struct Group: Codable, Identifiable {
    var id: UUID
    var name: String
    var description: String?
}
