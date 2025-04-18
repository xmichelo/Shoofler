import SwiftUI

@main
struct ShooflerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            Button("Quit") {
                NSApplication.shared.terminate(self)
            }
            .keyboardShortcut("q", modifiers: .command)
        }
    }
}
