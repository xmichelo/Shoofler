import Foundation
import ComposableArchitecture

@Reducer
struct ShooflerFeature {
    @MainActor static let sampleState = State(
        settings: SettingsFeature.State(),
        vault: VaultFeature.State(groups: GroupList.sample, snippets: SnippetList.sample),
        input: InputFeature.State(),
        substituter: SubstituterFeature.State(),
    )
    
    @ObservableState
    struct State: Equatable {
        var settings = SettingsFeature.State()
        var vault = VaultFeature.State()
        var input = InputFeature.State()
        var substituter = SubstituterFeature.State()

    }
    
    enum Action {
        case settings(SettingsFeature.Action)
        case vault(VaultFeature.Action)
        case input(InputFeature.Action)
        case substituter(SubstituterFeature.Action)
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
        
        Scope(state: \.substituter, action: \.substituter) {
            SubstituterFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .input(.accumulatorChanged(let accum)):
                print("accum is: \(accum)")
                if accum == "xxem" {
                    print("Performing substitution")
                    let subst = Substitution(eraseCount: 4, newText: "xavier@michelon.ch")
                    return .send(.substituter(.performSubstitution(subst)))
                }
                return .none
                
            case .substituter(.substitutionWasPerformed):
                return .send(.input(.resetAccumulator))
                
            default:
                return .none
            }
        }
    }
}
