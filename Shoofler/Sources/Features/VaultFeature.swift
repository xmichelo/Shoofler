import Foundation
import ComposableArchitecture

@Reducer
struct VaultFeature {
    @ObservableState
    struct State: Equatable {
        var groups: GroupList = []
        var snippets: SnippetList = []
        var selectedGroup: Group?
        var selectedSnippet: Snippet?
    }
    
    enum Action {
        case groupSelected(Group?)
        case snippetSelected(Snippet?)
        case checkForMatch(String)
        case snippetHasMatched(Snippet)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .groupSelected(let group):
                state.selectedGroup = group
                state.selectedSnippet = nil
                return .none
                
            case .snippetSelected(let snippet):
                state.selectedSnippet = snippet
                return .none
                
            case .checkForMatch(let trigger):
                let snippet = state.snippets.first { trigger.hasSuffix($0.trigger) }
                guard let snippet = snippet else { return .none }
                return .send(.snippetHasMatched(snippet))
                
            case .snippetHasMatched(_):
                return .none
            }
        }
    }
}
