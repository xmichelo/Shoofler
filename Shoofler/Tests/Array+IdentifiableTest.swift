import Foundation
import Testing

@testable import Shoofler

@Test("ArrayIdentifiableSubscript[id]")
func testArrayIdentifiableSubscript() async throws {
    let uuid = UUID()
    let snippetList: SnippetList = [
        Snippet(id: uuid, trigger: "trigger1", content: "snippet1"),
        Snippet(trigger: "trigger2", content: "snippet2"),
        Snippet(id: uuid, trigger: "trigger3", content: "snippet3"),
    ]
    #expect(snippetList.count == 3)
    #expect(snippetList[uuid]?.trigger == "trigger1")
    #expect(snippetList[UUID()] == nil)
}

@Test("ArrayIdentifiable.addReplace()")
func testSnippetListAddReplace() async throws {
    var snippetList: SnippetList = []
    snippetList.appendReplace(testSnippets[0])
    #expect(snippetList.count == 1)
    snippetList.appendReplace(testSnippets[1])
    #expect(snippetList.count == 2)
    snippetList.appendReplace(testSnippets[0])
    #expect(snippetList.count == 2)
    snippetList.appendReplace(testSnippets[2])
    snippetList.appendReplace(testSnippets[2])
    snippetList.appendReplace(testSnippets[2])
    #expect(snippetList.count == 3)
}

@Test("ArrayIdentifiable.sanitize()")
func testSnippetListSanitize() async throws {
    let uuid1 = UUID()
    let uuid2 = UUID()
    let snippetList: SnippetList = SnippetList([
        Snippet(id: uuid1, trigger: "trigger1", content: "snippet1"),
        Snippet(trigger: "trigger2", content: "snippet2"),
        Snippet(id: uuid2, trigger: "trigger3", content: "snippet3"),
        Snippet(id: uuid1, trigger: "trigger4", content: "snippet4"),
        Snippet(id: uuid1, trigger: "trigger5", content: "snippet5"),
        Snippet(id: uuid2, trigger: "trigger6", content: "snippet6"),
    ]).sanitized()
    
    #expect(snippetList.count == 3)
    #expect(snippetList[uuid1]?.trigger == "trigger1")
    #expect(snippetList[uuid2]?.trigger == "trigger3")
    #expect(snippetList[UUID()] == nil)
}

@Test("ArrayIdentifiable.contains(id:)")
func testSnippetListContainsID() async throws {
    testSnippets.forEach {snippet in
        #expect(testSnippets.contains(id: snippet.id))

    }
    #expect(!testSnippets.contains(id: UUID()))
}
