import Foundation
import ComposableArchitecture

@Reducer
struct ShooflerFeature {
    static let sampleState = State(
        settings: SettingsFeature.State(),
        groups: GroupListFeature.State(groups: GroupList.sample),
        snippets: SnippetListFeature.State(snippets: SnippetList.sample),        
    )
    
    @ObservableState
    struct State: Equatable {
        var settings = SettingsFeature.State()
        var groups = GroupListFeature.State()
        var snippets = SnippetListFeature.State()
    }
    
    enum Action {
        case settings(SettingsFeature.Action)
        case groups(GroupListFeature.Action)
        case snippets(SnippetListFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.settings, action: \.settings) {
            SettingsFeature()
        }
        
        Scope(state: \.groups, action: \.groups) {
            GroupListFeature()
        }
        
        Scope(state: \.snippets, action: \.snippets) {
            SnippetListFeature()
        }
        
        Reduce { state, action in
            return .none
        }
    }
}
