import Foundation
import ComposableArchitecture
import SwiftUI

@MainActor
class AppConfig {
    static let shared = AppConfig()
    var store: StoreOf<AppFeature> = Store(initialState: AppFeature.State()) { AppFeature() }
    
    private init() {}
}

@Reducer
struct AppFeature {
    @MainActor static let sampleState = State(
        engine: EngineFeature.sampleState,
    )
    
    @ObservableState
    struct State: Equatable {
        var settings = SettingsFeature.State()
        var engine = EngineFeature.State()
        
        var triggerOpenMainWindow: Bool = false
        var triggerOpenSettings: Bool = false
    }
    
    enum Action {
        case settings(SettingsFeature.Action)
        case engine(EngineFeature.Action)
        
        case openMainWindow
        case openSettings
        case quit
        
        case resetTriggerOpenMainWindow
        case resetTriggerOpenSettings
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.settings, action: \.settings) {
            SettingsFeature()
        }

        Scope(state: \.engine, action: \.engine) {
            EngineFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .openMainWindow:
                if !state.triggerOpenMainWindow {
                    print("UIActionsFeature: .openMainWindow")
                    state.triggerOpenMainWindow = true
                }
                return .none
                
            case .openSettings:
                if !state.triggerOpenSettings {
                    print("UIActionsFeature: .openSettings")
                    state.triggerOpenSettings = true
                }
                return .none

            case .quit:
                print("UIActionsFeature: .quit")
                Task { @MainActor in
                    NSApplication.shared.terminate(self)
                }
                return .none
                
            case .resetTriggerOpenMainWindow:
                if state.triggerOpenMainWindow {
                    print("UIActionsFeature: .resetTriggerOpenMainWindow")
                    state.triggerOpenMainWindow = false
                }
                return .none
                
            case .resetTriggerOpenSettings:
                if state.triggerOpenSettings {
                    print("UIActionsFeature: .resetTriggerOpenSettings")
                    state.triggerOpenSettings = false
                }
                return .none
                
            case .settings, .engine:
                return .none
            }
        }
    }
}

@main
struct ShooflerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.openWindow) var openWindow
    @Environment(\.openSettings) var openSettings
    
    var store = AppConfig.shared.store
    private var monitor: Any?
    static let mainWIndowID = "shoofler-main-window"
    
    init() {
        store.scope(state: \.settings, action: \.settings).send(.loadSettingsBlocking)
        let inputStore = store.scope(state: \.engine.input, action: \.engine.input)
        inputStore.send(.installKeyboardMonitor(inputStore))
    }
    
    var body: some Scene {
        Window("Shoofler", id: ShooflerApp.mainWIndowID) {
            ContentView(store: store.scope(state: \.engine.vault, action: \.engine.vault))
                .preferredColorScheme(store.settings.theme.colorScheme)
                .onAppear {
                    setDockIconVisibility(visible: true)
                }
                .onDisappear() {
                    setDockIconVisibility(visible: false)
                }
        }
        .defaultLaunchBehavior(store.settings.showWindowOnStartup ? .automatic : .suppressed)
        .windowStyle(.automatic)
        .windowToolbarStyle(.unified)
        .onChange(of: store.triggerOpenMainWindow) {
            if !store.triggerOpenMainWindow {
                return
            }
            print("onChange(of: .triggerOpenMainWindow")
            openWindow(id: ShooflerApp.mainWIndowID)
            NSApp.activate(ignoringOtherApps: true)
            store.send(.resetTriggerOpenMainWindow)

        }
        .onChange(of: store.triggerOpenSettings) {
            if !store.triggerOpenSettings {
                return
            }
            
            print("onChange(of: .triggerOpenSettings")
            openSettings()
            NSApp.activate(ignoringOtherApps: true)
            store.send(.resetTriggerOpenSettings)
        }

        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarView(store: store)
        }

        Settings {
            SettingsView.init(store: store.scope(state: \.settings, action: \.settings))
        }
    }
}
