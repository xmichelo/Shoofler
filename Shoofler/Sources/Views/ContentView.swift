import SwiftUI
import ComposableArchitecture

public struct ContentView: View {
    @Bindable var store: StoreOf<VaultFeature>
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isAccessibilityEnabled = AXIsProcessTrusted()
    
    public var body: some View {
        VStack {
            if isAccessibilityEnabled {
                NavigationView(store: store)
            } else {
                AccessibilityRequestView()
            }
        }.onReceive(timer) { _ in
            isAccessibilityEnabled = AXIsProcessTrusted();
            logDebug("Timer triggered. isAccessibilityEnabled: \(isAccessibilityEnabled)")
        }.onChange(of: isAccessibilityEnabled) {
            @Dependency(\.appStore) var appStore
            if (!isAccessibilityEnabled) {
                logInfo("Application does not have accessibility permissions anymore. Showing main window.")
                appStore.send(.openMainWindow)
            } else {
                logInfo("The application now has accessibility permissions.")
                let inputStore = appStore.scope(state: \.engine.input, action: \.engine.input)
                inputStore.send(.installKeyboardMonitor(inputStore))
            }
            logDebug("Is accessibility enabled: \(isAccessibilityEnabled)")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: EngineFeature.sampleState.vault, reducer: {
            VaultFeature()
        }))
        .frame(width: 800, height: 600)
    }
}
