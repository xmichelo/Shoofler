import ComposableArchitecture
import SwiftUI

@Reducer
struct SettingsFeature: Sendable {
    @ObservableState
    struct State: Equatable {
        var theme: Theme = .system
        var showWindowOnStartup: Bool = false
    }
    
    var settingsClient: SettingsClientProtocol = AppStorageSettingsClient()
    
    
    enum Action {
        case loadSettingsBlocking
        case loadSettings
        case saveSettings
        case settingsLoaded(TaskResult<SettingsFeature.State>)
        case settingsSaved(TaskResult<Void>)
        case showWindowOnStartupToggled(Bool)
        case themeSelected(Theme)
    }
    
    func loadSettings() -> State {
        do {
            return try settingsClient.load()
        } catch {
            return State()
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadSettingsBlocking:
                state = self.loadSettings()
                return .none
                
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
            case .showWindowOnStartupToggled(let isOn):
                state.showWindowOnStartup = isOn
                return .send(.saveSettings)
            case .themeSelected(let theme):
                state.theme = theme
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
                    Toggle(
                        "Show window on startup",
                        isOn: $store.showWindowOnStartup.sending(\.showWindowOnStartupToggled)
                    )
                    Spacer()
                }
                .padding()
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
