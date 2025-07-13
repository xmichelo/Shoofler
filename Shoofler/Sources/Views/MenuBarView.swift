import SwiftUI
import ComposableArchitecture

struct MenuBarView: View {
    var store: StoreOf<UIActionsFeature>
    
    var body: some View {
        Button("Open Shoofler") {
            store.send(.openMainWindow)
        }
        .keyboardShortcut("\n", modifiers: [])
        
        Divider()
        
        Button ("Settings") {
            store.send(.openSettings)
        }
        
        Divider()
        
        Button("Quit") {
            store.send(.quit)
        }
        .keyboardShortcut("q", modifiers: .command)
        
        UIActionView(store: store)
    }
}
