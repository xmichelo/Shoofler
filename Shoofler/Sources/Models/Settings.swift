import Foundation
import SwiftUI

protocol SettingsClientProtocol {
    func load() async throws -> SettingsFeature.State
    func save(_ settings: SettingsFeature.State) async throws
}

struct AppStorageSettingsClient: SettingsClientProtocol {
    @AppStorage("theme") private var theme: Theme = .system
    @AppStorage("dummy") private var dummy: Bool = false
    
    func load() async throws -> SettingsFeature.State {
        return SettingsFeature.State(
            theme: theme,
            dummy: dummy,
        )
    }
    
    func save(_ settings: SettingsFeature.State) async throws {
        theme = settings.theme
        dummy = settings.dummy
    }
}

struct NullSettingsClient: SettingsClientProtocol {
    func load() async throws -> SettingsFeature.State {
        return SettingsFeature.State()
    }
    
    func save(_ settings: SettingsFeature.State) async throws {}
}

