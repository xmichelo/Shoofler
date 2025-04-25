import SwiftUI

@main
struct ShooflerApp: App {
    static let mainWIndowID = "shoofler-main-window"
    @AppStorage("theme") private var theme: Theme = .system
    
    var body: some Scene {
        Window("Shoofler", id: ShooflerApp.mainWIndowID) {
            ContentView()
                .preferredColorScheme(theme.colorScheme)
        }
        
        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarContentView()
        }
        
        Settings(content: SettingsView.init)
    }
}
