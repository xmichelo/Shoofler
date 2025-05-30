import Foundation
import Testing

@testable import Shoofler

let testGroupIDs = [UUID(), UUID(), UUID(), UUID()]
let testGroups: GroupList = [
    Group(id: testGroupIDs[0], name: "Group 1", description: "First test group."),
    Group(id: testGroupIDs[1], name: "Group 2", description: "Second test group."),
    Group(id: testGroupIDs[2], name: "Group 3", description: "Third test group."),
    Group(id: testGroupIDs[3], name: "Group 4", description: "Fourth test group."),
]

//
//struct GroupListTests {
//    @Test("GroupsList.init(from:)")
//    func testGroupsListFromArray() {
//        #expect(testGroups.count == 4)
//        #expect(GroupList().count == 0)
//        
//        let uuid1 = UUID()
//        let uuid2 = UUID()
//        let groupList: GroupList = [
//            Group(id: uuid1, name: "Group 1"),
//            Group(id: uuid2, name: "Group 2"),
//            Group(id: uuid1, name: "Group 3"),
//        ]
//        
//        #expect(groupList.count == 3)
//        let group = groupList[uuid]
//        #expect(group?.name == "Group 3")
//    }
//    
//    @Test("GroupList.contains(id:)")
//    func testGroupListContainsID() {
//        for id in testGroupIDs {
//            #expect(testGroups.contains(id: id))
//        }
//        #expect(!testGroups.contains(id: UUID()))
//    }
//
//    @Test("GroupList.add()")
//    func testGroupListAdd() {
//        var groups = testGroups
//        let group = groups.first?.value
//        #expect(group != nil)
//        var g = group!
//        g.name = "dummy name"
//        groups.add(g)
//        #expect(groups.count == 4)
//        #expect(groups[g.id]?.name == "dummy name")
//        g.id = UUID()
//        groups.add(g)
//        #expect(groups.count == 5)
//    }
//}
