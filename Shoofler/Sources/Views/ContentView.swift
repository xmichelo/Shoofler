import SwiftUI

public struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isAccessibilityEnabled = AXIsProcessTrusted()
    
    public init() {}

    public var body: some View {
        VStack {
            if isAccessibilityEnabled {
                Text("Shoofler")
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
        ContentView()
    }
}
