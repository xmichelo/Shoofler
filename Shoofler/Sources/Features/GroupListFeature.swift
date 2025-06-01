import ComposableArchitecture

@Reducer
struct GroupListFeature {
    @ObservableState
    struct State: Equatable {
        var groups: GroupList = []
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
