import SwiftUI
import ComposableArchitecture

struct SnippetListView: View {
    let store: StoreOf<SnippetListFeature>
    var group: Group?
    @Binding var selectedSnippet: Snippet?
    
    var body: some View {
        List(store.snippets.snippetsOf(group: group?.id ?? UUID()), selection: $selectedSnippet) { snippet in
            NavigationLink(value: snippet) {
                SnippetItemView(snippet: snippet)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button(action: {}) {
                    Image(systemName: "square.and.pencil")
                }
                .disabled(selectedSnippet == nil)
                .help("Edit Snippet")

                Button(action: {}) {
                    Image(systemName: "plus")
                }
                .help("Add Snippet")
                
                Button(action: {}) {
                    Image(systemName: "trash")
                }
                .disabled(selectedSnippet == nil)
                .help("Delete Snippet")                
            }
        }
    }
}

#Preview {
    SnippetListView(
        store: Store(initialState: SnippetListFeature.State(), reducer: {
            SnippetListFeature()
        }),
        group: GroupList.sample.first,
        selectedSnippet: .constant(nil))
}
