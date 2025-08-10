import ComposableArchitecture
import SwiftUI

@Reducer
struct SettingsFeature: Sendable {
    @ObservableState
    struct State: Equatable {
        var theme: Theme = .system
        var showWindowOnStartup: Bool = false
        var startOnLogin: Bool = false
    }
    
    var settingsClient: SettingsClientProtocol = AppStorageSettingsClient()
    let loginItemManager = LoginItemManager()
    
    
    enum Action {
        case loadSettingsBlocking
        case loadSettings
        case saveSettings
        case settingsLoaded(SettingsFeature.State)
        case showWindowOnStartupToggled(Bool)
        case startOnLoginToggled(Bool)
        case themeSelected(Theme)
    }
    
    func loadSettings()  async -> State {
        do {
            var state = try (settingsClient.load as () throws -> SettingsFeature.State)()
            state.startOnLogin = await loginItemManager.isEnabled()
            return state
        } catch {
            var state = SettingsFeature.State()
            state.startOnLogin = await loginItemManager.isEnabled()
            logError("Failed to load settings: \(error)")
            return state
        }
    }
    
    // this function exist because on startup we want to ensure the settings are properly loaded before we do anything.
    func loadSettingsBLocking() -> State {
        let semaphore = DispatchSemaphore(value: 0)
        var state = State()
        Task {
            state = await loadSettings()
            semaphore.signal()
        }
        semaphore.wait()
        return state
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadSettingsBlocking:
                state = loadSettingsBLocking()
                return .send(.settingsLoaded(loadSettingsBLocking()))
                
            case .loadSettings:
                return .run { send in
                    let state = await loadSettings()
                    await send(.settingsLoaded(state))
                }
                
            case .saveSettings:
                return .run { [state] send in
                    do {
                        try await settingsClient.save(state)
                    } catch {
                        logError("Failed to save settings: \(error)")
                    }
                }
                
            case .settingsLoaded(let settings):
                state = settings
                return .none
            
            case .showWindowOnStartupToggled(let isOn):
                state.showWindowOnStartup = isOn
                return .send(.saveSettings)
            
            case .startOnLoginToggled(let isOn):
                state.startOnLogin = isOn
                return .run { [loginItemManager] send in
                    do {
                        try await loginItemManager.setEnabled(isOn)
                    } catch {
                        logError("Failed to set login item: \(error)")
                    }
                }
                
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
                GeneralSettingsTabView(store: store)
                .padding()
            }
            
            Tab("Appearance", systemImage: "display") {
                AppearanceSettingsTabView(store: store)
                .padding()
            }
        }
        .frame(width: 300, alignment: .leading)
        .preferredColorScheme(store.theme.colorScheme)
        .onAppear {
            store.send(.loadSettings)
        }
    }
}

struct GeneralSettingsTabView: View {
    @Bindable var store: StoreOf<SettingsFeature>
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle(
                "Show window on startup",
                isOn: $store.showWindowOnStartup.sending(\.showWindowOnStartupToggled)
            )
            Toggle(
                "Start on login",
                isOn: $store.startOnLogin.sending(\.startOnLoginToggled)
            )
            Spacer()
        }
    }
}

struct AppearanceSettingsTabView: View {
    @Bindable var store: StoreOf<SettingsFeature>
    
    var body: some View {
        VStack {
            HStack {
                Picker("Theme", selection: $store.theme.sending(\.themeSelected)) {
                    ForEach(Theme.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                Spacer()

            }
            Spacer()
        }
    }
}
#Preview {
    SettingsView(store: Store(initialState: SettingsFeature.State()) { SettingsFeature() })
}
