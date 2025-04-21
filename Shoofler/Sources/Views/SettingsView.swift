import SwiftUI

struct SettingsView: View {
    @AppStorage("theme") var theme: Theme = .system

    var body: some View {
        TabView {
            Tab("Appearance", systemImage: "display") {
                VStack {
                    ThemeSelectorView()
                    Spacer()
                }
                .padding()
            }
        }
        .preferredColorScheme(theme.colorScheme)
    }
}

#Preview {
    SettingsView()
}
