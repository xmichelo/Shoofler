import SwiftUI

@main
struct ShooflerApp: App {
    @Bindable var store = DataStore.shared
    private var monitor: Any?
    static let mainWIndowID = "shoofler-main-window"
    
    var body: some Scene {
        
        Window("Shoofler", id: ShooflerApp.mainWIndowID) {
            ContentView()
            .preferredColorScheme(store.settings.theme.colorScheme)
            .onAppear {
                store.scope(state: \.settings, action: \.settings).send(.loadSettings)
                NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
                    print(event)
                }
            }
        }
        
        
        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarContentView()
        }
        
        Settings { SettingsView.init(store: store.scope(state: \.settings, action: \.settings)) }
    }
}
