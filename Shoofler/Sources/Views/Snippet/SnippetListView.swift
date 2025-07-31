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
                    .simultaneousGesture(
                        TapGesture().onEnded { _ in
                            logVerbose("Snippet clicked: \(snippet.trigger)")
                            store.send(.snippetSelected(snippet))
                        }
                    )
                    .simultaneousGesture(
                        TapGesture(count: 2).onEnded { _ in
                            logVerbose("Snippet double clicked: \(snippet.trigger)")
                            store.send(.snippetDoubleClicked(snippet))
                        }
                    )
                    .dropDestination(for: Snippet.self) { snippets, location in
                        for droppedSnippet in snippets {
                            store.send(.snippetDroppedOnSnippet((droppedSnippet, snippet.id)))
                        }
                        return true
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
