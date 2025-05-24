import Foundation
import Testing

@testable import Shoofler

let testGroups = [
    Group(name: "Group 1", description: "First test group."),
    Group(name: "Group 2", description: "Second test group."),
    Group(name: "Group 3", description: "Third test group."),
    Group(name: "Group 4", description: "Third test group."),
]

let testSnippets = SnippetList.from(
    array: [
        Snippet(trigger: "zz0", snippet: "This is snippet #0", description: "A test snippet at index 0", group: testGroups[0].id),
        Snippet(trigger: "zz1", snippet: "This is snippet #1", description: "A test snippet at index 1", group: testGroups[0].id),
        Snippet(trigger: "zz2", snippet: "This is snippet #2", description: "A test snippet at index 2", group: testGroups[0].id),
        Snippet(trigger: "zz3", snippet: "This is snippet #3", description: "A test snippet at index 3", group: testGroups[1].id),
        Snippet(trigger: "zz4", snippet: "This is snippet #4", description: "A test snippet at index 4", group: testGroups[1].id),
        Snippet(trigger: "zz5", snippet: "This is snippet #5", description: "A test snippet at index 5", group: nil),
        Snippet(trigger: "zz6", snippet: "This is snippet #6", description: "A test snippet at index 6", group: testGroups[2].id),
        Snippet(trigger: "zz7", snippet: "This is snippet #7", description: "A test snippet at index 7", group: testGroups[0].id),
        Snippet(trigger: "zz8", snippet: "This is snippet #8", description: "A test snippet at index 8", group: nil),
    ]
)

let testVault = Vault(groups: testGroups, snippets: testSnippets)

struct SnippetListTests {
    @Test("SnipperLst.from(array:)")
    func testSnippetListFromArray() {
        #expect(testSnippets.count == 9)
        #expect(testSnippets[8].snippet == "This is snippet #8")

        #expect(SnippetList.from(array: []).count == 0)
        
        let testSnippets: [Snippet] = [
            Snippet(trigger: "trigger1", snippet: "snippet1"),
            Snippet(trigger: "trigger2", snippet: "snippet2"),
        ]
        #expect(SnippetList.from(array: testSnippets).count == 2);
    }
    
    @Test("SnippetList.contains(id:)")
    func testSnippetListContainsID() async throws {
        testSnippets.forEach { snippet in
            #expect(testSnippets.contains(id: snippet.id))

        }
        #expect(!testSnippets.contains(id: UUID()))
    }
    
    @Test("SnippetListfilter(isIncluded:)")
    func testSnippetListFilter() {
        var i = 0;
        let filtered = testSnippets.filter { snippet in
            i += 1
            return (i - 1) % 2 == 0
        }
        #expect(filtered.count == 5)
        #expect(filtered[4].snippet == "This is snippet #8")
    }
    
    @Test("SnippetList.add()")
    func testSnippetListAdd() async throws {
        var snippets = testSnippets
        let count = snippets.count
        let newSnippet = Snippet(trigger: "newTrigger", snippet: "newSnippet")
        snippets.add(newSnippet)
        #expect(snippets.count == count + 1)
        #expect(snippets.contains(id: newSnippet.id))
        var existingSnippet = snippets.first!
        existingSnippet.snippet = "updatedSnippet"
        snippets.add(existingSnippet)
        #expect(snippets.count == count + 1)
        #expect(snippets.first!.snippet == "updatedSnippet")
    }

    @Test("SnippetList.snippetsOf(groupID:)")
    func testSnippetListSnippetsOfGroupID() async throws {
        #expect(testSnippets.snippetsOf(groupID: testVault.groups[0].id).count == 4)
        #expect(testSnippets.snippetsOf(groupID: testVault.groups[1].id).count == 2)
        #expect(testSnippets.snippetsOf(groupID: testVault.groups[2].id).count == 1)
        #expect(testSnippets.snippetsOf(groupID: testVault.groups[3].id).count == 0)
        #expect(testSnippets.snippetsOf(groupID: UUID()).count == 0)
    }
}
