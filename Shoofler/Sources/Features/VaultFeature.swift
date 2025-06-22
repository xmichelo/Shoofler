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
        
        @Presents var addEditSnippet: AddEditSnippetFeature.State? = nil

        static func == (lhs: VaultFeature.State, rhs: VaultFeature.State) -> Bool {
            return lhs.groups == rhs.groups &&
                lhs.snippets == rhs.snippets &&
                lhs.selectedGroup == rhs.selectedGroup &&
                lhs.selectedSnippet == rhs.selectedSnippet
        }
    }
    
    enum Action {
        case groupSelected(Group?)
        case snippetSelected(Snippet?)
        case addSnippetActionTriggered
        case editSnippetActionTriggered
        case checkForMatch(String)
        case snippetHasMatched(Snippet)
        
        case addEditSnippet(PresentationAction<AddEditSnippetFeature.Action>)
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
                
            case .addSnippetActionTriggered:
                let snippet = Snippet(trigger: "", content: "", group: state.selectedGroup?.id)
                state.addEditSnippet = AddEditSnippetFeature.State(snippet: snippet)
                return .none
                
            case .editSnippetActionTriggered:
                guard let snippet = state.selectedSnippet else { return .none }
                state.addEditSnippet = AddEditSnippetFeature.State(snippet: snippet)
                return .none
                
            case .checkForMatch(let trigger):
                let snippet = state.snippets.first { trigger.hasSuffix($0.trigger) }
                guard let snippet = snippet else { return .none }
                return .send(.snippetHasMatched(snippet))
                
            case .snippetHasMatched(_):
                return .none
             
            case .addEditSnippet(.presented(.delegate(.saveSnippet(let snippet)))):
                state.snippets.updateOrAppend(snippet)
                state.selectedSnippet = snippet
                return .none
                
            case .addEditSnippet:
                return .none
            }
        }
        .ifLet(\.$addEditSnippet, action: \.addEditSnippet) {
            AddEditSnippetFeature()
        }
    }
}
