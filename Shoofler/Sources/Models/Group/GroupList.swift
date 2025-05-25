import Foundation

typealias GroupList = [UUID:Group]

public extension GroupList {
    /// Initializes a snippet list from an array of snippets.
    ///
    /// if a duplicate ID is present, only the last group with this ID will be in the returned list.
    ///
    /// - parameters:
    ///     - array: the array of snippets.
    ///
    /// - returns: The snippet list build using the snippets in array.
    init(from array: [Group]) {
        self = .init(minimumCapacity: array.count)
        array.forEach { self[$0.id] = $0 }
    }

    /// Test whether the list contains a group with the given ID.
    ///
    /// - parameters:
    ///     - id The group ID.
    ///
    /// - returns:
    ///     - true if and only if the list contains the group with the given ID.
    func contains(id: UUID) -> Bool {
        return self.keys.contains(id)
    }
    
    /// Adds or replaces a group to the list.
    ///
    /// - parameters:
    ///     - group: The group to add or replace.
    mutating func add(_ group: Group) {
        self[group.id] = group
    }
}

public extension GroupList {
    /// A sample group list.
    static var sample: Self {
        var groupList = GroupList()
        groupList.add(Group(id: UUID(), name: "First Group", description: "First group"))
        groupList.add(Group(id: UUID(), name: "Second Group", description: "Second group"))
        groupList.add(Group(id: UUID(), name: "Third Group"))
        return groupList
    }
    

}
