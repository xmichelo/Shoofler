import ComposableArchitecture

@Reducer
struct SnippetListFeature {
    @ObservableState
    struct State: Equatable {
        var snippets: SnippetList = []
        var selectedSnippet: Snippet?
    }
    
    enum Action {
        case snippetSelected(Snippet?)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .snippetSelected(let snippet):
                state.selectedSnippet = snippet
                return .none
            }
        }
    }
}
