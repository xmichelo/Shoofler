import Foundation

typealias GroupList = [UUID: Group]

extension GroupList {
    /// A sample group list.
    static var sample: GroupList {
        var groupList = GroupList()
        groupList.add(Group(id: UUID(), name: "First Group", description: "First group"))
        groupList.add(Group(id: UUID(), name: "Second Group", description: "Second group"))
        groupList.add(Group(id: UUID(), name: "Third Group"))
        return groupList
    }
    
    /// Initalizer that use an array of group to initialize the ``GroupList``.
    ///
    /// - Parameters:
    ///     - groups: The array of groups.
    init(groups: [Group]) {
        self.init()
        groups.forEach { group in
            self[group.id] = group
        }
    }
    
    /// Add or replace a group to the list.
    ///
    /// - parameters:
    ///     - group: The group to add or replace.
    mutating func add(_ group: Group) {
        self[group.id] = group
    }
}
