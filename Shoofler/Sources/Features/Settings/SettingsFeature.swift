import ComposableArchitecture
import SwiftUI

@Reducer
struct SettingsFeature: Sendable {
    @ObservableState
    struct State: Equatable {
        var theme: Theme = .system
        var dummy: Bool = false
    }
    
    var settingsClient: SettingsClientProtocol = AppStorageSettingsClient()
    
    enum Action {
        case loadSettings
        case saveSettings
        case settingsLoaded(TaskResult<SettingsFeature.State>)
        case settingsSaved(TaskResult<Void>)
        case themeSelected(Theme)
        case toggledDummy(Bool)
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadSettings:
                return .run { send in
                    await send(
                        .settingsLoaded(
                            TaskResult { try await settingsClient.load() }
                        )
                    )
                }
            case .saveSettings:
                let s = state
                return .run { send in
                    await send(
                        .settingsSaved(
                            TaskResult { try await settingsClient.save(s) }
                        )
                    )
                }
            case .settingsLoaded(.success(let settings)):
                state = settings
                return .none
            case .settingsLoaded(.failure):
                return .none
            case .settingsSaved(.success()):
                return .none
            case .settingsSaved(.failure):
                return .none
            case .themeSelected(let theme):
                state.theme = theme
                return .send(.saveSettings)
            case .toggledDummy(let dummy):
                state.dummy = dummy
                return .send(.saveSettings)
            }
        }
    }
}

struct SettingsView: View {
    @Bindable var store: StoreOf<SettingsFeature>
    
    var body: some View {
        TabView {
            Tab("General", systemImage: "slider.horizontal.3") {
                VStack {
                    Section("General") {
                        Toggle("Dummy", isOn: $store.dummy.sending(\.toggledDummy))
                    }
                    .padding()
                    Spacer()
                }
            }
            Tab("Appearance", systemImage: "display") {
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
        .frame(minWidth: 300)
        .preferredColorScheme(store.theme.colorScheme)
        .onAppear {
            store.send(.loadSettings)
        }
    }
}

#Preview {
    SettingsView(store: Store(initialState: SettingsFeature.State()) { SettingsFeature() })
}
