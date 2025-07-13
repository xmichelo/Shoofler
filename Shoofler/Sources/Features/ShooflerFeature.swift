import Foundation
import ComposableArchitecture

@Reducer
struct ShooflerFeature {
    @MainActor static let sampleState = State(
        menuBar: MenuBarFeature.State(),
        settings: SettingsFeature.State(),
        engine: EngineFeature.sampleState,
    )
    
    @ObservableState
    struct State: Equatable {
        var menuBar = MenuBarFeature.State()
        var settings = SettingsFeature.State()
        var engine = EngineFeature.State()
    }
    
    enum Action {
        case menuBar(MenuBarFeature.Action)
        case settings(SettingsFeature.Action)
        case engine(EngineFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.menuBar, action: \.menuBar) {
            MenuBarFeature()
        }
        
        Scope(state: \.settings, action: \.settings) {
            SettingsFeature()
        }

        Scope(state: \.engine, action: \.engine) {
            EngineFeature()
        }
        
        Reduce { state, action in
            return .none
        }
    }
}
