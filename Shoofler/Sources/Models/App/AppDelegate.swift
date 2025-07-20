import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("Application did finish launching.")
        if !AXIsProcessTrusted() {
            AppConfig.shared.store.send(.openMainWindow)
        }
    }
    
//    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
//        reopenCount += 1
//        if reopenCount > 2 { // The first two calls are part of the launch and should be ignored.
//            AppConfig.shared.store.send(.uiActions(.openMainWindow))
//        }
//        return true
//    }
}
