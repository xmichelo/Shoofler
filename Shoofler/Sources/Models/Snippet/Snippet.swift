import Foundation

/// Structure describing a snippet
struct Snippet: Codable, Identifiable {
    var id: UUID
    var trigger: String
    var snippet: String
    var description: String?
    var group: UUID?
    
    init(id: UUID = .init(), trigger: String, snippet: String, description: String? = nil, group: UUID? = nil) {
        self.id = id
        self.trigger = trigger
        self.snippet = snippet
        self.description = description
        self.group = group
    }
}
