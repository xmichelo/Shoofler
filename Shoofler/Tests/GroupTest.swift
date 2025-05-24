import Foundation
import Testing

@testable import Shoofler

struct GroupsTests {
    @Test("Group.init")
    func testGroupInit() {
        let uuid = UUID()
        let group = Group.init(id: uuid, name: "name", description: "description")
        #expect(group.id == uuid)
        #expect(group.name == "name")
        #expect(group.description == "description")
    }
}
