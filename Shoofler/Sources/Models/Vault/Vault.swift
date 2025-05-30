import Foundation

/// A structure representing a vault that stores snippets.
struct Vault: Codable {
    /// The list of groups.
    var groups: GroupList
    
    /// The list of snippets.
    var snippets: SnippetList
    
    func snippetsOf(group groupID: UUID) -> SnippetList {
        return snippets.snippetsOf(group: groupID)
    }
}

extension Vault {
    // MARK: - Sample data

    /// A sample vault.
    static var sample: Vault {
        var vault = Vault(groups: .sample, snippets: .sample)
        if vault.groups.isEmpty {
            return vault
        }
        
        // we assigned groups, except to the first item.
        var i = 0
        vault.snippets = vault.snippets.map { snippet in
            var snippet = snippet
            snippet.groupID = i != 0 ? vault.groups[i % vault.groups.count].id : nil
            i += 1
            return snippet
        }
        
        return vault
    }
}
