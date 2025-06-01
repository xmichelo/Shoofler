import Foundation
import ComposableArchitecture

@Reducer
struct VaultFeature {
    @ObservableState
    struct State: Equatable {
        var groups: GroupList
        var snippets: GroupList
    }
    
    enum Action {
        case addReplaceGroup(Group)
        case deleteGroup(UUID)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addReplaceGroup(_):
                return .none
            case .deleteGroup(_):
                return .none
            }
        }
    }
}
