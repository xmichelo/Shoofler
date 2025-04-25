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
                        let path = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!.appendingPathComponent("keyboard.log")
                        do { try "A key was pressed".write(to: path, atomically: true, encoding: String.Encoding.utf8) } catch {}
                        print("A key was pressed")
                    }
                }
        }
        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarContentView()
        }
        
        Settings(content: SettingsView.init)
    }
}
