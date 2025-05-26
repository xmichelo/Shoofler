import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct AppearanceSettingsFeature {
    @ObservableState
    struct State: Equatable {
        var theme: Theme = .system
    }
    
    enum Action {
        case themeSelected(Theme)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .themeSelected(let theme):
                if state.theme == theme {
                    return .none
                }
                state.theme = theme
                print("Theme is now \(state.theme)")
            }
            return .none
        }
    }
}

struct AppearanceSettingsView: View {
    @Bindable var store: StoreOf<AppearanceSettingsFeature>
    
    var body: some View {
        VStack {
            Picker("Theme", selection: $store.theme.sending(\.themeSelected)) {
                ForEach(Theme.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            Spacer()
        }
        .padding()
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
