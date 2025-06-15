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
                NavigationLink(value: snippet) {
                    SnippetItemView(snippet: snippet)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button(action: {}) {
                        Image(systemName: "square.and.pencil")
                    }
                    .disabled(store.selectedSnippet == nil)
                    .help("Edit Snippet")
                    
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                    .help("Add Snippet")
                    
                    Button(action: {}) {
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
