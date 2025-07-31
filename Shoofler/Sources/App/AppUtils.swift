import SwiftUI

/// Toggles the dock icon visibility
///
/// - Parameters:
///   - visible: should the dock icon be visible.
@MainActor
func setDockIconVisibility(visible: Bool) {
    NSApp.setActivationPolicy(visible ? .regular : .accessory)
}
