@testable import Shoofler

let testGroups = [
    Group(name: "Group 1", description: "First test group."),
    Group(name: "Group 2", description: "Second test group."),
    Group(name: "Group 3", description: "Third test group."),
    Group(name: "Group 4", description: "Third test group."),
]

let testSnippets = [
    Snippet(trigger: "zz1", snippet: "This is snippet #1", description: "A fist test snippet", group: testGroups[0].id),
    Snippet(trigger: "zz2", snippet: "This is snippet #2", description: "A second test snippet", group: testGroups[0].id),
    Snippet(trigger: "zz3", snippet: "This is snippet #3", description: "A third test snippet", group: testGroups[0].id),
    Snippet(trigger: "zz4", snippet: "This is snippet #4", description: "A fourth test snippet", group: testGroups[1].id),
    Snippet(trigger: "zz5", snippet: "This is snippet #5", description: "A fifth test snippet", group: testGroups[1].id),
    Snippet(trigger: "zz6", snippet: "This is snippet #6", description: "A sixth test snippet", group: nil),
    Snippet(trigger: "zz7", snippet: "This is snippet #7", description: "A seventh test snippet", group: testGroups[2].id),
    Snippet(trigger: "zz8", snippet: "This is snippet #8", description: "An eighth test snippet", group: testGroups[0].id),
    Snippet(trigger: "zz9", snippet: "This is snippet #9", description: "A ninth test snippet", group: nil),
]

let testVault = Vault(groups: testGroups, snippets: testSnippets)
