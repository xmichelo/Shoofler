import Foundation
import Testing

@testable import Shoofler

struct SHooflerTests {
    @Test
    func testSampleGroup() async throws {
        let vault = Vault.sample
        debugPrint(vault)
    }
}
