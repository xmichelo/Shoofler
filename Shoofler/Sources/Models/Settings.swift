import Foundation
import SwiftUI

protocol SettingsClientProtocol: Sendable {
    func load() async throws -> SettingsFeature.State
    func load() throws -> SettingsFeature.State
    func save(_ settings: SettingsFeature.State) async throws
    func save(_ settings: SettingsFeature.State) throws
}

struct AppStorageSettingsClient: SettingsClientProtocol {
    @AppStorage("theme") private var theme: Theme = .system
    @AppStorage("showWindowOnStartup") private var showWindowOnStartup: Bool = false
    
    func load() async throws -> SettingsFeature.State {
        return SettingsFeature.State(
            theme: theme,
            showWindowOnStartup: showWindowOnStartup
            
        )
    }
    
    func load() throws -> SettingsFeature.State {
        return SettingsFeature.State(
            theme: theme,
            showWindowOnStartup: showWindowOnStartup
            
        )
    }
    
    func save(_ settings: SettingsFeature.State) async throws {
        theme = settings.theme
        showWindowOnStartup = settings.showWindowOnStartup
    }

    func save(_ settings: SettingsFeature.State) throws {
        theme = settings.theme
        showWindowOnStartup = settings.showWindowOnStartup
    }
}

struct NullSettingsClient: SettingsClientProtocol {
    func load() async throws -> SettingsFeature.State {
        return SettingsFeature.State()
    }
    
    func load() throws -> SettingsFeature.State {
        return SettingsFeature.State()
    }
    
    func save(_ settings: SettingsFeature.State) async throws {}

    func save(_ settings: SettingsFeature.State) throws {}
}

