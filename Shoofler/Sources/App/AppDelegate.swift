import SwiftUI
import ComposableArchitecture

class AppDelegate: NSObject, NSApplicationDelegate {
    @Dependency(\.appStore) var appStore
    
    var reopenCount: Int = 0
    var shuttingDown: Bool = false
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupLogging()
        logInfo("Shoofler has started.")
        
        appStore.send(.systemMonitor(.startMonitoring))
//        if !appHasAccessibilityPermissions() {
//            // We want to force the window to be displayed.
//            logWarn("The application does not have accessibility permissions. The main window will open.")
//            appStore.send(.openMainWindow)
//        } else {
//            logInfo("The application has accessibility permissions.")
//            let inputStore: StoreOf<InputFeature> = appStore.scope(state: \.engine.input, action: \.engine.input)
//            inputStore.send(.installKeyboardMonitor())
//        }
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
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        if shuttingDown {
            logInfo("Shoofler is shutting down.")
            return .terminateNow
        } else {
            appStore.send(.performShutdownSequence)
            shuttingDown = true
            return .terminateCancel
        }
    }
}
