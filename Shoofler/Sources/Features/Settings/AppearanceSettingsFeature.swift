import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct AppearanceSettingsFeature {
    struct State: Equatable {
        var dummy: Bool = false
    }
    
    enum Action {
        case setTheme(Theme)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}

struct AppearanceSettingsView: View {
    let store: StoreOf<AppearanceSettingsFeature>
    
    var body: some View {
        Text("Appearance Settings")
    }
}

#Preview {
    AppearanceSettingsView(
        store: Store(
            initialState: AppearanceSettingsFeature.State()
        ) {
            AppearanceSettingsFeature()
        }
    )
}
