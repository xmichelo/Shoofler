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
        
        @Presents var addEditSnippet: AddEditSnippetFeature.State?
        @Presents var addEditGroup: AddEditGroupFeature.State?
        @Presents var alert: AlertState<Action.Alert>?
        
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
        case addEditSnippet(PresentationAction<AddEditSnippetFeature.Action>)
        case deleteSnippetActionTriggered(id: Snippet.ID)
        case addGroupActionTriggered
        case editGroupActionTriggered
        case addEditGroup(PresentationAction<AddEditGroupFeature.Action>)
        case deleteGroupActionTriggered(id: Group.ID)
        case checkForMatch(String)
        case snippetHasMatched(Snippet)
        case alert(PresentationAction<Alert>)

        enum Alert: Equatable {
            case confirmSnippetDeletion(id: Snippet.ID)
            case confirmGroupDeletion(id: Group.ID)
        }
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

            case .addEditSnippet(.presented(.delegate(.saveSnippet(let snippet)))):
                state.snippets.updateOrAppend(snippet)
                state.selectedSnippet = snippet
                return .none

            case .addEditSnippet:
                return .none

            case let .alert(.presented(.confirmSnippetDeletion(id: id))):
                state.snippets.remove(id: id)
                return .none

            case let .deleteSnippetActionTriggered(id: id):
                state.alert = AlertState {
                    TextState("Are you sure you want to delete this snippet?")
                } actions: {
                    ButtonState(role: .destructive, action: .confirmSnippetDeletion(id: id)) {
                        TextState("Delete")
                    }
                }
                return .none
                
            case .addGroupActionTriggered:
                let group = Group(name: "")
                state.addEditGroup = AddEditGroupFeature.State(group: group)
                return .none
                
            case .editGroupActionTriggered:
                guard let group = state.selectedGroup else { return .none }
                state.addEditGroup = AddEditGroupFeature.State(group: group)
                return .none

            case .addEditGroup(.presented(.delegate(.saveGroup(let group)))):
                state.groups.updateOrAppend(group)
                state.selectedGroup = group
                return .none
                
            case .addEditGroup:
                return .none

            case let .alert(.presented(.confirmGroupDeletion(id: id))):
                state.groups.remove(id: id)
                return .none

            case let .deleteGroupActionTriggered(id: id):
                state.alert = AlertState {
                    TextState("Are you sure you want to delete this group?")
                } actions: {
                    ButtonState(role: .destructive, action: .confirmGroupDeletion(id: id)) {
                        TextState("Delete")
                    }
                }
                return .none
                
            case .checkForMatch(let trigger):
                let snippet = state.snippets.first { trigger.hasSuffix($0.trigger) }
                guard let snippet = snippet else { return .none }
                return .send(.snippetHasMatched(snippet))
                
            case .snippetHasMatched(_):
                return .none
             
                
            case .alert:
                return .none
                
            }
        }
        .ifLet(\.$addEditSnippet, action: \.addEditSnippet) {
            AddEditSnippetFeature()
        }
        .ifLet(\.$addEditGroup, action: \.addEditGroup) {
            AddEditGroupFeature()
        }
        .ifLet(\.alert, action: \.alert)
    }
}
