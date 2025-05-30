import Foundation
import Testing

@testable import Shoofler

struct SnippetListTests {
    @Test("SnippetList.snippetsOf(groupID:)")
    func testSnippetListSnippetsOfGroupID() async throws {
        #expect(testSnippets.snippetsOf(group: testGroupIDs[0]).count == 4)
        #expect(testSnippets.snippetsOf(group: testGroupIDs[1]).count == 2)
        #expect(testSnippets.snippetsOf(group: testGroupIDs[2]).count == 1)
        #expect(testSnippets.snippetsOf(group: testGroupIDs[3]).count == 0)
        #expect(testSnippets.snippetsOf(group: UUID()).count == 0)
    }
}
