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
    var store = AppConfig.shared.store
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
        
        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarContentView()
        }
        
        Settings { SettingsView.init(store: store.scope(state: \.settings, action: \.settings)) }
    }
}

@MainActor
func setDockIconVisibility(visible: Bool) {
    NSApp.setActivationPolicy(visible ? .regular : .accessory)
}
