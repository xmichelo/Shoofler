import SwiftUI
import ComposableArchitecture
import Carbon

@main
struct ShooflerApp: App {
    @Bindable var store: StoreOf<ShooflerFeature> = Store(initialState: ShooflerFeature.sampleState) { ShooflerFeature() }
    private var monitor: Any?
    
    static let mainWIndowID = "shoofler-main-window"
    
    init() {
        store.scope(state: \.settings, action: \.settings).send(.loadSettings)
    }
    
    var body: some Scene {
        var accum: String = ""
        
        Window("Shoofler", id: ShooflerApp.mainWIndowID) {
            ContentView(store: store.scope(state: \.vault, action: \.vault))
            .preferredColorScheme(store.settings.theme.colorScheme)
            .onAppear {
                NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
                    //print(event)
                    let resetters = [
                        kVK_Escape,
                        kVK_Space,
                        kVK_Return,
                        kVK_Tab,
                        kVK_UpArrow,
                        kVK_DownArrow,
                        kVK_LeftArrow,
                        kVK_RightArrow,
                        kVK_Home,
                        kVK_End,
                        kVK_PageUp,
                        kVK_PageDown,
                        kVK_ForwardDelete,
                    ]
                    
                    let intCode = Int(event.keyCode)
                    
                    if resetters.contains(intCode) {
                        print("Resetting accumulator")
                        accum = ""
                        return
                    }
                    
                    if intCode == kVK_Delete {
                        if (!accum.isEmpty) {
                            accum.removeLast()
                        }
                        print("Delete. Accum is now \(accum)")
                        return
                    }
                    
                    if let chars = event.characters {
                        if !chars.isEmpty {
                            accum += chars
                        }
                    }
                                        
                    if accum == "lorem" {
                        print("I should print lorem")
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString("lorem ipsum", forType: .string)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            let source = CGEventSource(stateID: .hidSystemState)
                            let backspaceDown = CGEvent(keyboardEventSource: source, virtualKey: 0x33, keyDown: true)
                            let backspaceUp = CGEvent(keyboardEventSource: source, virtualKey: 0x33, keyDown: false)
                            let keyDown = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: true)
                            let keyUp = CGEvent(keyboardEventSource: source, virtualKey: 0x09, keyDown: false)
                            
                            keyDown?.flags = .maskCommand
                            keyUp?.flags = .maskCommand
                            for _ in 0..<accum.count {
                                backspaceDown?.post(tap: .cghidEventTap)
                                backspaceUp?.post(tap: .cghidEventTap)
                            }
                            keyDown?.post(tap: .cghidEventTap)
                            keyUp?.post(tap: .cghidEventTap)
                        }
                    }
                    
                }
            }
        }
        .windowStyle(.automatic)
        .windowToolbarStyle(.unified)
        
        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarContentView()
        }
        
        Settings { SettingsView.init(store: store.scope(state: \.settings, action: \.settings)) }
    }
}
