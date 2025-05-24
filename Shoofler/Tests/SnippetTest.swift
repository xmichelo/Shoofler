import Foundation
import Testing

@testable import Shoofler

struct SnippetTests {
    @Test("Snippet.init")
    func testSnippetInit() {
        let uuid = UUID()
        let guuid = UUID()
        var snippet = Snippet(id: uuid, trigger: "trigger", snippet: "snippet", description: "description", group: guuid)
        #expect(snippet.id == uuid)
        #expect(snippet.trigger == "trigger")
        #expect(snippet.snippet == "snippet")
        #expect(snippet.description == "description")
        #expect(snippet.groupID == guuid)
        
        snippet = Snippet(trigger: "trigger", snippet: "snippet")
        #expect(snippet.trigger == "trigger")
        #expect(snippet.snippet == "snippet")
        #expect(snippet.description == nil)
        #expect(snippet.groupID == nil)
    }
}
