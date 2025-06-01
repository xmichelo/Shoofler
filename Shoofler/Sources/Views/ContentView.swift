import SwiftUI
import ComposableArchitecture

public struct ContentView: View {
    let store: StoreOf<ShooflerFeature>
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: ShooflerFeature.State(), reducer: {
            ShooflerFeature()
        }))
        .frame(width: 800, height: 600)
    }
}
