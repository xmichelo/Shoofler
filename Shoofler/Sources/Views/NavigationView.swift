import SwiftUI
import ComposableArchitecture

struct NavigationView: View {
    @Bindable var store: StoreOf<VaultFeature>
    @State private var splitViewVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $splitViewVisibility) {
            GroupListView(store: store)
                .navigationSplitViewColumnWidth(min: 250, ideal: 350)
        } content: {
            SnippetListView(store: store)
                .navigationSplitViewColumnWidth(min: 250, ideal: 350)
        }detail: {
            SnippetDetailsView(snippet: store.selectedSnippet)
                .navigationSplitViewColumnWidth(min: 250, ideal: 500)
        }
        .navigationSplitViewStyle(.balanced)
        .navigationTitle("")
        .sheet(item: $store.scope(state: \.addEditSnippet, action: \.addEditSnippet)) { addEditSnippetStore in
            NavigationStack {
                AddEditSnippetView(store: addEditSnippetStore)
            }
        }
        .sheet(item: $store.scope(state: \.addEditGroup, action: \.addEditGroup)) { addEditGroupStore in
            NavigationStack {
                AddEditGroupView(store: addEditGroupStore)
            }
        }
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    NavigationView(store: Store(initialState: EngineFeature.sampleState.vault){
        VaultFeature()
    })
    .frame(width: 1000, height: 400)
}
