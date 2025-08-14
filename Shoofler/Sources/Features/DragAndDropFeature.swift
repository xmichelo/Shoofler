import ComposableArchitecture
import SwiftUI

@Reducer
struct DragAndDropFeature {
    @ObservableState
    struct State: Equatable {
        @Shared(.groups) var groups: GroupList = []
        @Shared(.snippets) var snippets: SnippetList = []
    }
    
    enum Action {
        case snippetDroppedOnGroup((Snippet, Group.ID))
        case snippetDroppedOnSnippet((Snippet, Snippet.ID))
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .snippetDroppedOnGroup((let snippet, let groupID)):
                _ = state.$snippets.withLock { snippets in
                    snippets[id: snippet.id]?.groupID = groupID
                }
                return .none
                
            case .snippetDroppedOnSnippet((let snippet, let targetSnippetID)):
                withAnimation(.spring(duration: 6.0)) {
                    state.$snippets.withLock { snippets in
                        guard
                            let srcIndex = snippets.index(id: snippet.id),
                            let dstIndex = snippets.index(id: targetSnippetID)
                        else {
                            return
                        }
                        let indexSet = IndexSet(integer: srcIndex)
                        snippets.move(fromOffsets: indexSet,
                                      toOffset:dstIndex
                        )
                    }
                }
                return .none
            }
        }
    }
}
