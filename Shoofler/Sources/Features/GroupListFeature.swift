import ComposableArchitecture

@Reducer
struct GroupListFeature {
    @ObservableState
    struct State: Equatable {
        var groups: GroupList = []
        var selectedGroup: Group?
    }
    
    enum Action {
        case groupSelected(Group?)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .groupSelected(let group):
                state.selectedGroup = group
                return .none
            }
        }
    }
}
