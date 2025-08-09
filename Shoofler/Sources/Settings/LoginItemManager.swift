import Foundation
@preconcurrency import ServiceManagement

actor LoginItemManager {
    private let service = SMAppService.mainApp
    
    func isEnabled() -> Bool {
        return service.status == .enabled
    }
    
    func setEnabled(_ enabled: Bool) async throws {
        if enabled {
            if !isEnabled() {
                try service.register()
                logInfo("Registered applications as login item.")
            }
        } else {
            if isEnabled() {
                try await service.unregister()
                logInfo("Unregistered application as login item.")
            }
        }
    }
}
