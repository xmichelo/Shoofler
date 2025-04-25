import SwiftUI

struct AccessibilityRequestView: View {
    
    public var body: some View {
        VStack {
            Text("Accessibility permission request")
                .font(.title)
                .padding(.bottom, 20)
            
            Text("Shoofler needs accessibility permissions in order to operate.\n"
                 + "Click the button below and make sure to enable ")
            .multilineTextAlignment(.center)
            .padding(.bottom, 20)
            
            Button("Let's do it!") {
                AXIsProcessTrustedWithOptions(
                    [kAXTrustedCheckOptionPrompt.takeUnretainedValue(): true] as CFDictionary
                )
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(20)
    }
}

#Preview {
    AccessibilityRequestView()
        .frame(minWidth: 300, minHeight: 200)
}
