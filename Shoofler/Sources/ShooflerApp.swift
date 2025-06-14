import SwiftUI
import ComposableArchitecture
import Carbon

@main
struct ShooflerApp: App {
    @Bindable var store: StoreOf<ShooflerFeature> = Store(initialState: ShooflerFeature.sampleState) { ShooflerFeature() }
    private var monitor: Any?
    
    static let mainWIndowID = "shoofler-main-window"
    
    init() {
        store.scope(state: \.settings, action: \.settings).send(.loadSettings)
        let inputStore = store.scope(state: \.input, action: \.input)
        inputStore.send(.installKeyboardMonitor(inputStore))
    }
    
    var body: some Scene {
        Window("Shoofler", id: ShooflerApp.mainWIndowID) {
            ContentView(store: store.scope(state: \.vault, action: \.vault))
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

