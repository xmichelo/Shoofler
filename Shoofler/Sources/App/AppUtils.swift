import SwiftUI

@MainActor
func setDockIconVisibility(visible: Bool) {
    NSApp.setActivationPolicy(visible ? .regular : .accessory)
}

func appHasAccessibilityPermissions() -> Bool {
    return AXIsProcessTrusted()
}
