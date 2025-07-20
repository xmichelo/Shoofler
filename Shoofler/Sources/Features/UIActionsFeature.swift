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
        case resetTriggerOpenSettings
    }
    
    var body: some ReducerOf<Self> {
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
            }
        }
    }
}
