import SwiftUI
import ComposableArchitecture

public struct ContentView: View {
    var appStore: StoreOf<AppFeature>
    
    public var body: some View {
        VStack {
            if !appStore.systemMonitor.appHasAccessibilityPermissions {
                AccessibilityRequestView()
            } else {
                NavigationView(store: appStore.scope(state: \.engine.vault, action: \.engine.vault))
            }
        }
    }
}

#Preview {
    ContentView(
        appStore: Store(initialState: AppFeature.State()) {
            AppFeature()
        }
    )
}
