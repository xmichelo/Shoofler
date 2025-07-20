import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var reopenCount: Int = 0
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("Application did finish launching.")
        if !AXIsProcessTrusted() {
            AppConfig.shared.store.send(.openMainWindow)
        }
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        // The first two calls to this function are part of the regular app startup and should be ignored.
        reopenCount += 1
        if reopenCount > 2 {
            print("A re-opening of the application was requested.");
            AppConfig.shared.store.send(.openMainWindow)
        } else {
            print("Ignoring reopen event #\(reopenCount).")
        }
        return true
    }
}
