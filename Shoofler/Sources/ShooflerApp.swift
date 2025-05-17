import SwiftUI

@main
struct ShooflerApp: App {
    private var monitor: Any?
    static let mainWIndowID = "shoofler-main-window"
    @AppStorage("theme") private var theme: Theme = .system
    
    var body: some Scene {
        Window("Shoofler", id: ShooflerApp.mainWIndowID) {
            ContentView()
                .preferredColorScheme(theme.colorScheme)
                .onAppear {
                    NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
                        print(event)
                    }
                }
        }
        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarContentView()
        }
        
        Settings(content: SettingsView.init)
    }
}
