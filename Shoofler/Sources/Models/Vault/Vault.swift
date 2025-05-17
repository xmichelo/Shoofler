import Foundation

struct Vault: Codable {
    var groups: GroupList
    var snippets: SnippetList
    
    static var sample: Vault {
        var vault = Vault(groups: .sample, snippets: .sample)
        if vault.groups.isEmpty {
            return vault
        }

        let groups: [UUID] = vault.groups.keys.sorted()
        var i = 0
        vault.snippets = vault.snippets.mapValues { snippet in
            var snippet = snippet
            snippet.group = i != 0 ? groups[i % groups.count] : nil
            i += 1
            return snippet
        }
        
        return vault
    }
}
