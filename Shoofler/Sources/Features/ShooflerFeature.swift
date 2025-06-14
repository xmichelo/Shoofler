import Foundation
import ComposableArchitecture

@Reducer
struct ShooflerFeature {
    @MainActor static let sampleState = State(
        settings: SettingsFeature.State(),
        vault: VaultFeature.State(groups: GroupList.sample, snippets: SnippetList.sample),
        input: InputFeature.State()
    )
    
    @ObservableState
    struct State: Equatable {
        var settings = SettingsFeature.State()
        var vault = VaultFeature.State()
        var input = InputFeature.State()

    }
    
    enum Action {
        case settings(SettingsFeature.Action)
        case vault(VaultFeature.Action)
        case input(InputFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.settings, action: \.settings) {
            SettingsFeature()
        }
        
        Scope(state: \.vault, action: \.vault) {
            VaultFeature()
        }
        
        Scope(state: \.input, action: \.input) {
            InputFeature()
        }
        
        Reduce { state, action in
            return .none
        }
    }
}
