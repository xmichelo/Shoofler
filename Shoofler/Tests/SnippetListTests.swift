import Foundation
import Testing

@testable import Shoofler

let testSnippets = SnippetList(
    from: [
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

struct SnippetListTests {
    @Test("SnipperList(from:)")
    func testSnippetListFromArray() {
        #expect(testSnippets.count == 9)
        #expect(SnippetList(from: []).count == 0)
        
        let uuid = UUID()
        let snippets = [
            Snippet(id: uuid, trigger: "trigger1", content: "snippet1"),
            Snippet(trigger: "trigger2", content: "snippet2"),
            Snippet(id: uuid, trigger: "trigger3", content: "snippet3"),
        ]
        let snippetList = SnippetList(from: snippets)
        #expect(snippetList.count == 2)
        #expect(snippetList[uuid]?.trigger == "trigger3")
    }
    
    @Test("SnippetList.contains(id:)")
    func testSnippetListContainsID() async throws {
        testSnippets.forEach { _, snippet in
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
    }
    
    @Test("SnippetList.snippetsOf(groupID:)")
    func testSnippetListSnippetsOfGroupID() async throws {
        #expect(testSnippets.snippetsOf(group: testGroupIDs[0]).count == 4)
        #expect(testSnippets.snippetsOf(group: testGroupIDs[1]).count == 2)
        #expect(testSnippets.snippetsOf(group: testGroupIDs[2]).count == 1)
        #expect(testSnippets.snippetsOf(group: testGroupIDs[3]).count == 0)
        #expect(testSnippets.snippetsOf(group: UUID()).count == 0)
    }
}
