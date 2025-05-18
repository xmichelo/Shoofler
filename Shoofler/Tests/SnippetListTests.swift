import Foundation
import Testing

@testable import Shoofler

struct SnippetListTests {
    @Test("SnippetList.contains(id:)")
    func testSnippetListContainsID() async throws {
        testSnippets.forEach { snippet in
            #expect(testSnippets.contains(id: snippet.id))

        }
        #expect(!testSnippets.contains(id: UUID()))
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
