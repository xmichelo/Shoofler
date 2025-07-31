import Foundation
import ComposableArchitecture

public typealias GroupList = IdentifiedArrayOf<Group>

extension GroupList: Sendable {}

public extension GroupList {
    @MainActor static let sample: GroupList = [
        Group(id: UUID(0), name: "Professional", description: "A group containing Professional snippets."),
        Group(id: UUID(1), name: "Personal", description: "A group with personal snippets."),
        Group(id: UUID(2), name: "Emojis", description: "A group containing emoji related snippets.")
    ]
}
