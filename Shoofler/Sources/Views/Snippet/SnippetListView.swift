import SwiftUI
import ComposableArchitecture

struct SnippetListView: View {
    @Bindable var store: StoreOf<VaultFeature>
    
    var body: some View {
        if let selectedGroup = store.selectedGroup {
            List(
                store.snippets.snippetsOf(group: selectedGroup),
                selection: $store.selectedSnippet.sending(\.snippetSelected)
            ) { snippet in
                DraggableSnippetItemView(snippet: snippet, selected: store.selectedSnippet == snippet)
                    .contentShape(Rectangle())
                    .onTapGesture(count: 2) {
                        print("snippet double tapped: \(snippet.trigger)")
                        store.send(.snippetDoubleClicked(snippet))
                    }
                    .onTapGesture(count: 1) {
                        print("snippet tapped: \(snippet.trigger)")
                        store.send(.snippetSelected(snippet))
                    }
            }
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        store.send(.editSnippetActionTriggered)
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                    .disabled(store.selectedSnippet == nil)
                    .help("Edit Snippet")
                    
                    Button {
                        store.send(.addSnippetActionTriggered)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .help("Add Snippet")
                    
                    Button{
                        guard let snippet = store.selectedSnippet else { return }
                        store.send(.deleteSnippetActionTriggered(id: snippet.id))
                    } label: {
                        Image(systemName: "trash")
                    }
                    .disabled(store.selectedSnippet == nil)
                    .help("Delete Snippet")
                }
            }
        }
    }
}

#Preview {
    SnippetListView(
        store: Store(initialState: EngineFeature.sampleState.vault) {
            VaultFeature()
        }
    )
}
