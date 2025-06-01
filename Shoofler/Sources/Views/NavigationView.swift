import SwiftUI
import ComposableArchitecture

struct NavigationView: View {
    @Bindable var store: StoreOf<ShooflerFeature>
    @State private var splitViewVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $splitViewVisibility) {
            GroupListView(store: store)
                .navigationSplitViewColumnWidth(min: 250, ideal: 350)
        } content: {
            SnippetListView(store: store)
                .navigationSplitViewColumnWidth(min: 250, ideal: 350)
        }detail: {
            SnippetDetailsView(snippet: store.state.snippets.selectedSnippet)
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
