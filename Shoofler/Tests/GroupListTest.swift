import Foundation
import Testing

@testable import Shoofler


struct GroupListTests {
    @Test("GroupsList.init(from:)")
    func testGroupsListFromArray() {
        #expect(testGroups.count == 4)
        #expect(GroupList().count == 0)
        
        let uuid1 = UUID()
        let uuid2 = UUID()
        let groupList: GroupList = [
            Group(id: uuid1, name: "Group 1"),
            Group(id: uuid2, name: "Group 2"),
            Group(id: uuid1, name: "Group 3"),
        ]
        
        #expect(groupList.count == 3)
        let group = groupList[uuid1]
        #expect(group != nil)
        #expect(group!.name == "Group 1")
    }
    
    @Test("GroupList.contains(id:)")
    func testGroupListContainsID() {
        for id in testGroupIDs {
            #expect(testGroups.contains(id: id))
        }
        #expect(!testGroups.contains(id: UUID()))
    }

    @Test("GroupList.add()")
    func testGroupListAdd() {
        var groups = testGroups
        let group = groups.first
        #expect(group != nil)
        var g = group!
        g.name = "dummy name"
        groups.appendReplace(g)
        #expect(groups.count == 4)
        #expect(groups[g.id] != nil)
        #expect(groups[g.id]!.name == "dummy name")
        g.id = UUID()
        groups.appendReplace(g)
        #expect(groups.count == 5)
    }
}
