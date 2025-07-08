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
                return .send(.vault(.checkForMatch(accum)))
                
            case .substituter(.substitutionWasPerformed):
                return .send(.input(.resetAccumulator))
            
            case .vault(.snippetHasMatched(let snippet)):
                print("snippet was triggered: \(snippet.trigger)")
                return .send(
                    .substituter(
                        .performSubstitution(
                            Substitution(eraseCount: snippet.trigger.count, snippet: snippet.content)
                        )
                    )
                )
                
            default:
                return .none
            }
        }
    }
}
