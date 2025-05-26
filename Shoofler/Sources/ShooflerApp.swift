import SwiftUI

@main
struct ShooflerApp: App {
    @Bindable var store = DataStore.shared
    private var monitor: Any?
    static let mainWIndowID = "shoofler-main-window"
    
    var body: some Scene {
        Window("Shoofler", id: ShooflerApp.mainWIndowID) {
            ContentView()
                .preferredColorScheme(store.settings.appearance.theme.colorScheme)
                .onAppear {
                    NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
                        print(event)
                    }
                }
        }
        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarContentView()
        }
        
        SwiftUI.Settings(content: SettingsView.init)
    }
}
