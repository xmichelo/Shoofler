import ComposableArchitecture
import SwiftUI

struct GroupListView: View {
    @Bindable var store: StoreOf<VaultFeature>
    
    @State var searchText: String = ""
    
    func badgeValue(for group: Group) -> Int {
        return store.snippets.snippetsOf(group: group).count
    }
    
    var body: some View {
        VStack {
            List(store.groups, selection: $store.selectedGroup.sending(\.groupSelected)) { group in
                NavigationLink(value: group) {
                    GroupItemView(
                        group: group,
                        badgeValue: badgeValue(for: group))
                }
            }
            .navigationTitle("")
            .listStyle(SidebarListStyle())
            
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: {}) {
                    Image(systemName: "square.and.pencil")
                }
                .disabled(store.selectedGroup == nil)
                .help("Edit Group")

                Button(action: {}) {
                    Image(systemName: "plus")
                }
                .help("Add Group")
                
                Button(action: {}) {
                    Image(systemName: "trash")
                }
                .disabled(store.selectedGroup == nil)
                .help("Remove Group")
            }
        }
        .searchable(text: $searchText, prompt: "Search Snippets")
    }
}

#Preview {
    GroupListView(
        store: Store(initialState: EngineFeature.sampleState.vault) { VaultFeature() },
    )
}
