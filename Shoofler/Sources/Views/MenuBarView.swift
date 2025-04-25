import SwiftUI

struct MenuBarContentView: View {
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        Button("Open Shoofler") {
            NSApp.activate(ignoringOtherApps: true)
            openWindow(id: ShooflerApp.mainWIndowID)
        }
        .keyboardShortcut("\n", modifiers: [])
        
        Divider()
        
        Button("Quit") {
            NSApplication.shared.terminate(self)
        }
        .keyboardShortcut("q", modifiers: .command)
    }
}
