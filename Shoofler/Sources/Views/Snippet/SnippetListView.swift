import SwiftUI
import ComposableArchitecture

struct SnippetListView: View {
    @Bindable var store: StoreOf<ShooflerFeature>
    
    var body: some View {
        if let selectedGroup = store.groups.selectedGroup {
            List(
                store.snippets.snippets.snippetsOf(group: selectedGroup),
                selection: $store.snippets.selectedSnippet.sending(\.snippets.snippetSelected)
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
                    .disabled(store.snippets.selectedSnippet == nil)
                    .help("Edit Snippet")
                    
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                    .help("Add Snippet")
                    
                    Button(action: {}) {
                        Image(systemName: "trash")
                    }
                    .disabled(store.snippets.selectedSnippet == nil)
                    .help("Delete Snippet")
                }
            }
        }
    }
}

#Preview {
    SnippetListView(
        store: Store(initialState: ShooflerFeature.sampleState) { ShooflerFeature() }
    )
}
