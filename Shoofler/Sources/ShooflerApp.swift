import SwiftUI
import ComposableArchitecture
import Carbon

@MainActor
class AppConfig {
    static let shared = AppConfig()
    var store: StoreOf<ShooflerFeature> = Store(initialState: ShooflerFeature.State()) { ShooflerFeature() }
    
    private init() {}
}

@main
struct ShooflerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.openWindow) var openWindow
    @Environment(\.openSettings) var openSettings
    
    var store = AppConfig.shared.store
    private var monitor: Any?
    static let mainWIndowID = "shoofler-main-window"
    
    init() {
        store.scope(state: \.settings, action: \.settings).send(.loadSettingsBlocking)
        let inputStore = store.scope(state: \.engine.input, action: \.engine.input)
        inputStore.send(.installKeyboardMonitor(inputStore))
    }
    
    var body: some Scene {
        Window("Shoofler", id: ShooflerApp.mainWIndowID) {
            ContentView(store: store.scope(state: \.engine.vault, action: \.engine.vault))
                .preferredColorScheme(store.settings.theme.colorScheme)
                .onAppear {
                    setDockIconVisibility(visible: true)
                }
                .onDisappear() {
                    setDockIconVisibility(visible: false)
                }
        }
        .defaultLaunchBehavior(store.settings.showWindowOnStartup ? .automatic : .suppressed)
        .windowStyle(.automatic)
        .windowToolbarStyle(.unified)
        .onChange(of: store.scope(state: \.uiActions, action: \.uiActions).triggerOpenMainWindow) {
            let store = store.scope(state: \.uiActions, action: \.uiActions)
            if !store.triggerOpenMainWindow {
                return
            }
            print("onChange(of: .triggerOpenMainWindow")
            openWindow(id: ShooflerApp.mainWIndowID)
            NSApp.activate(ignoringOtherApps: true)
            store.send(.resetTriggerOpenMainWindow)

        }
        .onChange(of: store.scope(state: \.uiActions, action: \.uiActions).triggerOpenSettings) {
            let store = store.scope(state: \.uiActions, action: \.uiActions)
            if !store.triggerOpenSettings {
                return
            }
            
            print("onChange(of: .triggerOpenSettings")
            openSettings()
            NSApp.activate(ignoringOtherApps: true)
            store.send(.resetTriggerOpenSettings)
        }

        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarView(store: store.scope(state: \.uiActions, action: \.uiActions))
        }

        Settings {
            SettingsView.init(store: store.scope(state: \.settings, action: \.settings))
        }
    }
}

@MainActor
func setDockIconVisibility(visible: Bool) {
    NSApp.setActivationPolicy(visible ? .regular : .accessory)
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("Application did finish launching.")
        if !AXIsProcessTrusted() {
            AppConfig.shared.store.send(.uiActions(.openMainWindow))
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
