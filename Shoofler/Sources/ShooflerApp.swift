import SwiftUI
import ComposableArchitecture
import Carbon

@main
struct ShooflerApp: App {
    @Bindable var store: StoreOf<ShooflerFeature> = Store(initialState: ShooflerFeature.State()) { ShooflerFeature() }
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

