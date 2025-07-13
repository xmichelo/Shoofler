import Foundation
import ComposableArchitecture

@Reducer
struct ShooflerFeature {
    @MainActor static let sampleState = State(
        engine: EngineFeature.sampleState,
    )
    
    @ObservableState
    struct State: Equatable {
        var settings = SettingsFeature.State()
        var engine = EngineFeature.State()
        var uiActions = UIActionsFeature.State()
    }
    
    enum Action {
        case settings(SettingsFeature.Action)
        case engine(EngineFeature.Action)
        case uiActions(UIActionsFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.settings, action: \.settings) {
            SettingsFeature()
        }

        Scope(state: \.engine, action: \.engine) {
            EngineFeature()
        }
        
        Scope(state: \.uiActions, action: \.uiActions) {
            UIActionsFeature()
        }
        
        Reduce { state, action in
            return .none
        }
    }
}
