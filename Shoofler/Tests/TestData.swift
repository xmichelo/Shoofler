import Foundation

@testable import Shoofler

let testGroupIDs = [UUID(), UUID(), UUID(), UUID()]

let testGroups: GroupList = [
    Group(id: testGroupIDs[0], name: "Group 1", description: "First test group."),
    Group(id: testGroupIDs[1], name: "Group 2", description: "Second test group."),
    Group(id: testGroupIDs[2], name: "Group 3", description: "Third test group."),
    Group(id: testGroupIDs[3], name: "Group 4", description: "Fourth test group."),
]

let testSnippets = SnippetList(
    [
        Snippet(trigger: "zz0", content: "This is snippet #0", description: "A test snippet at index 0", group: testGroupIDs[0]),
        Snippet(trigger: "zz1", content: "This is snippet #1", description: "A test snippet at index 1", group: testGroupIDs[0]),
        Snippet(trigger: "zz2", content: "This is snippet #2", description: "A test snippet at index 2", group: testGroupIDs[0]),
        Snippet(trigger: "zz3", content: "This is snippet #3", description: "A test snippet at index 3", group: testGroupIDs[1]),
        Snippet(trigger: "zz4", content: "This is snippet #4", description: "A test snippet at index 4", group: testGroupIDs[1]),
        Snippet(trigger: "zz5", content: "This is snippet #5", description: "A test snippet at index 5", group: nil),
        Snippet(trigger: "zz6", content: "This is snippet #6", description: "A test snippet at index 6", group: testGroupIDs[2]),
        Snippet(trigger: "zz7", content: "This is snippet #7", description: "A test snippet at index 7", group: testGroupIDs[0]),
        Snippet(trigger: "zz8", content: "This is snippet #8", description: "A test snippet at index 8", group: nil),
    ]
)
let testVault = Vault(groups: testGroups, snippets: testSnippets)
