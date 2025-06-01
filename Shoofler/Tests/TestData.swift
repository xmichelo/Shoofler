import Foundation

@testable import Shoofler

let testGroups: GroupList = [
    Group(id: UUID(0), name: "Group 1", description: "First test group."),
    Group(id: UUID(1), name: "Group 2", description: "Second test group."),
    Group(id: UUID(2), name: "Group 3", description: "Third test group."),
    Group(id: UUID(3), name: "Group 4", description: "Fourth test group."),
]

let testSnippets: SnippetList = [
    Snippet(id: UUID(0), trigger: "zz0", content: "This is snippet #0", description: "A test snippet at index 0", group: UUID(0)),
    Snippet(id: UUID(1), trigger: "zz1", content: "This is snippet #1", description: "A test snippet at index 1", group: UUID(0)),
    Snippet(id: UUID(2), trigger: "zz2", content: "This is snippet #2", description: "A test snippet at index 2", group: UUID(0)),
    Snippet(id: UUID(3), trigger: "zz3", content: "This is snippet #3", description: "A test snippet at index 3", group: UUID(1)),
    Snippet(id: UUID(4), trigger: "zz4", content: "This is snippet #4", description: "A test snippet at index 4", group: UUID(1)),
    Snippet(id: UUID(5), trigger: "zz5", content: "This is snippet #5", description: "A test snippet at index 5", group: nil),
    Snippet(id: UUID(6), trigger: "zz6", content: "This is snippet #6", description: "A test snippet at index 6", group: UUID(2)),
    Snippet(id: UUID(7), trigger: "zz7", content: "This is snippet #7", description: "A test snippet at index 7", group: UUID(0)),
    Snippet(id: UUID(8), trigger: "zz8", content: "This is snippet #8", description: "A test snippet at index 8", group: nil),
]

