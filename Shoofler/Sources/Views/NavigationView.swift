import SwiftUI
import ComposableArchitecture

struct NavigationView: View {
    let store: StoreOf<ShooflerFeature>
    @State private var selectedGroup: Group?
    @State private var selectedSnippet: Snippet?
    @State private var splitViewVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $splitViewVisibility) {
            GroupListView(store: store, selectedGroup: $selectedGroup)
                .navigationSplitViewColumnWidth(min: 250, ideal: 350)
        } content: {
            
            SnippetListView(
                store: store.scope(state: \.snippets, action: \.snippets),
                group: selectedGroup,
                selectedSnippet: $selectedSnippet
            )
            .navigationSplitViewColumnWidth(min: 250, ideal: 350)
        }detail: {
            SnippetDetailsView(snippet: selectedSnippet)
                .navigationSplitViewColumnWidth(min: 250, ideal: 500)
        }
        .navigationSplitViewStyle(.balanced)
        .navigationTitle("")
    }
}

#Preview {
    NavigationView(store: Store(initialState: ShooflerFeature.State()){
        ShooflerFeature()
    })
    .frame(width: 1000, height: 400)
}
