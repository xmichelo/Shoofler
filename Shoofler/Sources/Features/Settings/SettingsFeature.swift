import ComposableArchitecture
import SwiftUI

@Reducer
struct SettingsFeature {
    struct State: Equatable {
        var general = GeneralSettingsFeature.State()
        var appearance = AppearanceSettingsFeature.State()
    }
    
    enum Action {
        case general(GeneralSettingsFeature.Action)
        case appearance(AppearanceSettingsFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.general, action: \.general) {
            GeneralSettingsFeature()
        }
        Scope(state: \.appearance, action: \.appearance) {
            AppearanceSettingsFeature()
        }
        Reduce { state, action in
            return .none
        }
    }
}

struct SettingsView: View {
    let store = Store(initialState: SettingsFeature.State()) {
        SettingsFeature()
    }
    
    var body: some View {
        TabView {
            Tab("General", systemImage: "slider.horizontal.3") {
                GeneralSettingsView(store: store.scope(state: \.general, action: \.general))
            }
            Tab("Appearance", systemImage: "display") {
                AppearanceSettingsView(store: store.scope(state: \.appearance, action: \.appearance))
            }
        }
        .frame(minWidth: 300)
        //.preferredColorScheme(theme.colorScheme)
    }
}

#Preview {
    SettingsView()
}
