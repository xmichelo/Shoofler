import SwiftUI

@main
struct ShooflerApp: App {
    @AppStorage("theme") private var theme: Theme = .system
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(theme.colorScheme)
        }
        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            Button("Quit") {
                NSApplication.shared.terminate(self)
            }
            .keyboardShortcut("q", modifiers: .command)
        }
        Settings(content: SettingsView.init)
    }
}
