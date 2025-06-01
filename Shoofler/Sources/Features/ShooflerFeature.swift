import Foundation
import ComposableArchitecture

@Reducer
struct ShooflerFeature {
    @MainActor static let sampleState = State(
        settings: SettingsFeature.State(),
        vault: VaultFeature.State(groups: GroupList.sample, snippets: SnippetList.sample)
    )
    
    @ObservableState
    struct State: Equatable {
        var settings = SettingsFeature.State()
        var vault = VaultFeature.State()

    }
    
    enum Action {
        case settings(SettingsFeature.Action)
        case vault(VaultFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.settings, action: \.settings) {
            SettingsFeature()
        }
        
        Scope(state: \.vault, action: \.vault) {
            VaultFeature()
        }
        
        Reduce { state, action in
            return .none
        }
    }
}
