import SwiftUI
import ComposableArchitecture

class AppDelegate: NSObject, NSApplicationDelegate {
    @Dependency(\.appStore) var appStore
    
    var reopenCount: Int = 0
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupLogging()
        logInfo("Shoofler has started.")
        if !AXIsProcessTrusted() {
            appStore.send(.openMainWindow)
        }
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        // The first two calls to this function are part of the regular app startup and should be ignored.
        reopenCount += 1
        if reopenCount > 2 {
            logDebug("A re-opening of the application was requested.");
            appStore.send(.openMainWindow)
        } else {
            logVerbose("Ignoring reopen event #\(reopenCount) as part of the regular app startup process.")
        }
        return true
    }
}
