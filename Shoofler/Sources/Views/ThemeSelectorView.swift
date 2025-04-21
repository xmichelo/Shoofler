import SwiftUI

/// A view that implement a theme selector (System/Dark/Light) for the app.
///
/// The theme is stored in the system preferences.
struct ThemeSelectorView: View {
    @AppStorage("theme") private var theme: Theme = .system

    var body: some View {
        Picker("Theme", selection: $theme) {
            ForEach(Theme.allCases) { mode in
                Text(mode.rawValue).tag(mode)
            }
        }
        .pickerStyle(.segmented)
    }
}
