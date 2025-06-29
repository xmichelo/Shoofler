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
                .dropDestination(for: Snippet.self) { snippets, location in
                    for snippet in snippets {
                        store.send(.snippetDroppedOnGroup((snippet, group.id)))
                    }
                    return true
                }

            }
            .navigationTitle("")
            .listStyle(SidebarListStyle())
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    store.send(.editGroupActionTriggered)
                } label: {
                    Image(systemName: "square.and.pencil")
                }
                .disabled(store.selectedGroup == nil)
                .help("Edit Group")

                Button {
                    store.send(.addGroupActionTriggered)
                } label: {
                    Image(systemName: "plus")
                }
                .help("Add Group")
                
                Button {
                    if let group = store.selectedGroup {
                        store.send(.deleteGroupActionTriggered(id: group.id))
                    }
                } label: {
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
