import ComposableArchitecture

@Reducer
struct EngineFeature {
    @MainActor static let sampleState = State(
        vault: VaultFeature.State(groups: GroupList.sample, snippets: SnippetList.sample),
        input: InputFeature.State(),
        substituter: SubstituterFeature.State(),
    )
    
    @ObservableState
    struct State: Equatable {
        var vault = VaultFeature.State()
        var input = InputFeature.State()
        var substituter = SubstituterFeature.State()
    }
    
    enum Action {
        case input(InputFeature.Action)
        case vault(VaultFeature.Action)
        case substituter(SubstituterFeature.Action)
    }

    var body: some ReducerOf<Self> {
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
