import Foundation
import Testing

@testable import Shoofler

struct SnippetTests {
    @Test("Snippet.init")
    func testSnippetInit() {
        let uuid = UUID()
        let guuid = UUID()
        var snippet = Snippet(id: uuid, trigger: "trigger", content: "snippet", description: "description", group: guuid)
        #expect(snippet.id == uuid)
        #expect(snippet.trigger == "trigger")
        #expect(snippet.content == "snippet")
        #expect(snippet.description == "description")
        #expect(snippet.groupID == guuid)
        
        snippet = Snippet(trigger: "trigger", content: "snippet")
        #expect(snippet.trigger == "trigger")
        #expect(snippet.content == "snippet")
        #expect(snippet.description == nil)
        #expect(snippet.groupID == nil)
    }
}
