import Foundation
import SwiftUI

struct Settings {
    var theme: Theme = .system
}

protocol SettingsClientProtocol {
    func load() async throws -> Settings
    mutating func save(_ settings:Settings) async throws
}

struct AppStorageSettingsClient: SettingsClientProtocol {
    @AppStorage("theme") private var theme: Theme = .system

    func load() async throws -> Settings {
        return Settings(theme: theme)
    }
    
    mutating func save(_ settings: Settings) async throws {
        theme = settings.theme
    }
}

struct NullSettingsClient: SettingsClientProtocol {
    func load() async throws -> Settings {
        return Settings()
    }
    mutating func save(_ settings: Settings) async throws {}
}

