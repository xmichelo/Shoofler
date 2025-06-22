import Foundation
import Testing

@testable import Shoofler

struct SnippetListTests {
    @Test("SnippetList.snippetsOf(groupID:)")
    func testSnippetListSnippetsOfGroupID() async throws {
        let snippets = testSnippets()
        let groups = testGroups()
        #expect(snippets.snippetsOf(group: groups[0]).count == 4)
        #expect(snippets.snippetsOf(group: groups[1]).count == 2)
        #expect(snippets.snippetsOf(group: groups[2]).count == 1)
        #expect(snippets.snippetsOf(group: groups[3]).count == 0)
    }
}
