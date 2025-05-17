import Foundation

/// Structure describing a snippet
struct Snippet: Codable, Identifiable {
    var id: UUID
    var trigger: String
    var snippet: String
    var description: String?
    var group: UUID?
}
