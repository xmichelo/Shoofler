import Foundation
import Testing

@testable import Shoofler

struct SnippetListTests {
    @Test("SnippetList.snippetsOf(groupID:)")
    func testSnippetListSnippetsOfGroupID() async throws {
        #expect(testSnippets.snippetsOf(group: testGroups[0]).count == 4)
        #expect(testSnippets.snippetsOf(group: testGroups[1]).count == 2)
        #expect(testSnippets.snippetsOf(group: testGroups[2]).count == 1)
        #expect(testSnippets.snippetsOf(group: testGroups[3]).count == 0)
    }
}
