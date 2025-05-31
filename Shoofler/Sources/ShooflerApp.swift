import SwiftUI
import ComposableArchitecture

@main
struct ShooflerApp: App {
    @Bindable var store: StoreOf<AppFeature>
    private var monitor: Any?
    
    static let mainWIndowID = "shoofler-main-window"
    
    init() {
        store = DataStore.shared
        store.scope(state: \.settings, action: \.settings).send(.loadSettings)
    }
    
    var body: some Scene {
        
        Window("Shoofler", id: ShooflerApp.mainWIndowID) {
            ContentView()
            .preferredColorScheme(store.settings.theme.colorScheme)
//            .onAppear {
//                NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
//                    print(event)
//                }
//            }
        }
        .windowStyle(.automatic)
        .windowToolbarStyle(.unified)
        
        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarContentView()
        }
        
        Settings { SettingsView.init(store: store.scope(state: \.settings, action: \.settings)) }
    }
}
