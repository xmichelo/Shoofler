import SwiftUI
import ComposableArchitecture
import Carbon

@main
struct ShooflerApp: App {
    @Bindable var store: StoreOf<ShooflerFeature> = Store(initialState: ShooflerFeature.State()) { ShooflerFeature() }
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    private var monitor: Any?
    static let mainWIndowID = "shoofler-main-window"
    
    init() {
        store.scope(state: \.settings, action: \.settings).send(.loadSettings)
        let inputStore = store.scope(state: \.engine.input, action: \.engine.input)
        inputStore.send(.installKeyboardMonitor(inputStore))
    }
    
    var body: some Scene {
        Window("Shoofler", id: ShooflerApp.mainWIndowID) {
            ContentView(store: store.scope(state: \.engine.vault, action: \.engine.vault))
            .preferredColorScheme(store.settings.theme.colorScheme)
        }
        .windowStyle(.automatic)
        .windowToolbarStyle(.unified)
        
        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarContentView()
        }
        
        Settings { SettingsView.init(store: store.scope(state: \.settings, action: \.settings)) }
    }
}

/// Delegate class to handle app events.
class AppDelegate: NSObject, NSApplicationDelegate {
    /// Callback triggered when the application is about to become active.
    ///
    /// - Parameters:
    ///    - notification: the event data
    func applicationWillBecomeActive(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular) // Show the Dock icon.
    }

    /// Callback triggered when the last application window is closed.
    ///
    /// - Parameters:
    ///    - sender: the application object
    ///
    /// - Returns: true if and only if the application should close.
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        NSApp.setActivationPolicy(.accessory) // Hide the Dock icon.
        return false
    }
}
