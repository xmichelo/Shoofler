import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct AppFeature {
    
    @ObservableState
    struct State: Equatable {
        var settings = SettingsFeature.State()
        var engine = EngineFeature.State()
        var systemMonitor = SystemMonitorFeature.State()
        
        var triggerOpenMainWindow: Bool = false
        var triggerOpenSettings: Bool = false
    }
    
    enum Action {
        case settings(SettingsFeature.Action)
        case engine(EngineFeature.Action)
        case systemMonitor(SystemMonitorFeature.Action)
        
        case openMainWindow
        case openSettings
        case quit
        
        case performShutdownSequence
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
        
        Scope(state: \.systemMonitor, action: \.systemMonitor) {
            SystemMonitorFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .openMainWindow:
                if !state.triggerOpenMainWindow {
                    logInfo("Opening main window.")
                    state.triggerOpenMainWindow = true
                }
                return .none
                
            case .openSettings:
                if !state.triggerOpenSettings {
                    logInfo("Opening settings window.")
                    state.triggerOpenSettings = true
                }
                return .none

            case .quit:
                logInfo("Application shutdown was requested.")
                Task { @MainActor in
                    NSApplication.shared.terminate(self)
                }
                return .none
                
            case .performShutdownSequence:
                logInfo("Performing shutdown sequence.")
                return .run { send in
                    await send(.systemMonitor(.stopMonitoring))
                    await send(.engine(.input(.removeEventMonitor)))
                    await NSApplication.shared.terminate(self)
                }
                
            case .resetTriggerOpenMainWindow:
                if state.triggerOpenMainWindow {
                    state.triggerOpenMainWindow = false
                }
                return .none
                
            case .resetTriggerOpenSettings:
                if state.triggerOpenSettings {
                    state.triggerOpenSettings = false
                }
                return .none
                
            case .systemMonitor(.accessibilityPermissionsChanged(let hasPermissions)):
                if hasPermissions {
                    logInfo("The application has accessibility permissions.")
                    return .send(.engine(.input(.addEventMonitor)))
                }
                logInfo("The application does not have accessibility permissions.")
                return .run { send in
                    await send(.engine(.input(.removeEventMonitor)))
                    await send(.openMainWindow)
                }
    
                
            case .settings, .engine, .systemMonitor:
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
    @Dependency(\.appStore) var appStore

    private var monitor: Any?
    static let mainWIndowID = "shoofler-main-window"
    
    init() {
        appStore.scope(state: \.settings, action: \.settings).send(.loadSettingsBlocking)
    }
    
    var body: some Scene {
        Window("Shoofler", id: ShooflerApp.mainWIndowID) {
            ContentView(appStore: appStore)
                .preferredColorScheme(appStore.settings.theme.colorScheme)
                .onAppear {
                    setDockIconVisibility(visible: true)
                }
                .onDisappear() {
                    setDockIconVisibility(visible: false)
                }
        }
        .defaultLaunchBehavior(appStore.settings.showWindowOnStartup ? .automatic : .suppressed)
        .windowStyle(.automatic)
        .windowToolbarStyle(.unified)
        .onChange(of: appStore.triggerOpenMainWindow) {
            if !appStore.triggerOpenMainWindow {
                return
            }
            logVerbose("onChange(of: .triggerOpenMainWindow)")
            openWindow(id: ShooflerApp.mainWIndowID)
            NSApp.activate(ignoringOtherApps: true)
            appStore.send(.resetTriggerOpenMainWindow)

        }
        .onChange(of: appStore.triggerOpenSettings) {
            if !appStore.triggerOpenSettings {
                return
            }
            
            logVerbose("onChange(of: .triggerOpenSettings)")
            openSettings()
            NSApp.activate(ignoringOtherApps: true)
            appStore.send(.resetTriggerOpenSettings)
        }

        MenuBarExtra("Shoofler", image: "MenuBarIcon") {
            MenuBarView(store: appStore)
        }

        Settings {
            SettingsView.init(store: appStore.scope(state: \.settings, action: \.settings))
        }
    }
}
