import SwiftUI

struct MenuBarContentView: View {
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        Button("Open Shoofler") {
            openWindow(id: ShooflerApp.mainWIndowID)
            NSApp.activate(ignoringOtherApps: true)
        }
        .keyboardShortcut("\n", modifiers: [])
        
        Divider()
        
        Button("Quit") {
            NSApplication.shared.terminate(self)
        }
        .keyboardShortcut("q", modifiers: .command)
    }
}
