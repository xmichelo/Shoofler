import Foundation

typealias GroupList = [UUID: Group]

extension GroupList {
    static var sample: GroupList {
        var groupList = GroupList()
        groupList.append(Group(id: UUID(), name: "First Group", description: "First group"))
        groupList.append(Group(id: UUID(), name: "Second Group", description: "Second group"))
        groupList.append(Group(id: UUID(), name: "Third Group"))
        return groupList
    }
    
    mutating func append(_ group: Group) {
        self[group.id] = group
    }
}
