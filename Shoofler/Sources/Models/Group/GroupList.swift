import Foundation

typealias GroupList = [Group]

extension GroupList {
    /// A sample group list.
    static var sample: GroupList {
        var groupList = GroupList()
        groupList.add(Group(id: UUID(), name: "First Group", description: "First group"))
        groupList.add(Group(id: UUID(), name: "Second Group", description: "Second group"))
        groupList.add(Group(id: UUID(), name: "Third Group"))
        return groupList
    }
    
    /// Adds or replaces a group to the list.
    ///
    /// - parameters:
    ///     - group: The group to add or replace.
    mutating func add(_ group: Group) {
        if let index = firstIndex(where: { $0.id == group.id }) {
            self[index] = group
        } else {
            append(group)
        }
    }
}
