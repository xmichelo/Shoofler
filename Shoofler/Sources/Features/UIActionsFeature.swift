import ComposableArchitecture
import SwiftUI

@Reducer
struct UIActionsFeature {
    @ObservableState
    struct State: Equatable {
        var triggerOpenMainWindow: Bool = false
        var triggerOpenSettings: Bool = false
    }
    
    enum Action {
        case openMainWindow
        case openSettings
        case quit
        
        case resetTriggerOpenMainWindow
        case resetTriggerSettings
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .openMainWindow:
                state.triggerOpenMainWindow = true
                return .none
            
            case .openSettings:
                state.triggerOpenSettings = true
                return .none
                
            case .quit:
                Task { @MainActor in
                    NSApplication.shared.terminate(self)
                }
                return .none
                
            case .resetTriggerOpenMainWindow:
                state.triggerOpenMainWindow = false
                return .none
                
            case .resetTriggerSettings:
                state.triggerOpenSettings = false
                return .none
            }
            
        }
    }
}

struct UIActionView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.openSettings) private var openSettings
    
    var store: StoreOf<UIActionsFeature>
    
    var body: some View {
        EmptyView()
            .onChange(of: store.triggerOpenMainWindow) {
                if store.triggerOpenMainWindow {
                    print("triggerOpenMainWindow")
                    openWindow(id: ShooflerApp.mainWIndowID)
                    NSApp.activate(ignoringOtherApps: true)
                    store.send(.resetTriggerOpenMainWindow)
                } else {
                    print("resetTriggerOpenMainWindow")
                }
            }
            .onChange(of: store.triggerOpenSettings) {
                if store.triggerOpenSettings {
                    print("triggerOpenSettings")
                    openSettings()
                    store.send(.resetTriggerSettings)
                } else {
                    print("resetTriggerSettings")
                }
            }

    }
}
