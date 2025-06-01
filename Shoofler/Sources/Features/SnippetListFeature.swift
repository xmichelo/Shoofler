import ComposableArchitecture

@Reducer
struct SnippetListFeature {
    @ObservableState
    struct State: Equatable {
        var snippets: SnippetList = []
    }
    
    enum Action {
        case dummy
    }
    
    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .dummy:
                return .none
            }
        }
    }
}
