import Foundation
import Testing

@testable import Shoofler

struct VaultTests {
    
    @Test("Vault.snippetsOf(Group:)")
    func testVaultSnippetsOfGroup() {
        let snippets = testVault.snippetsOf(group: testGroupIDs[0])
        #expect(snippets.count == 4)
        #expect(snippets == testVault.snippets.snippetsOf(group: testGroupIDs[0]))
    }
    
}
