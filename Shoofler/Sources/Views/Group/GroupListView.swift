import ComposableArchitecture
import SwiftUI

struct GroupListView: View {
    @Bindable var store: StoreOf<ShooflerFeature>
    
    @State var searchText: String = ""
    
    func badgeValue(for group: Group) -> Int {
        return store.snippets.snippets.snippetsOf(group: group).count
    }
    
    var body: some View {
        VStack {
            List(store.groups.groups, selection: $store.groups.selectedGroup.sending(\.groups.groupSelected)) { group in
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
                .disabled(store.groups.selectedGroup == nil)
                .help("Edit Group")

                Button(action: {}) {
                    Image(systemName: "plus")
                }
                .help("Add Group")
                
                Button(action: {}) {
                    Image(systemName: "trash")
                }
                .disabled(store.groups.selectedGroup == nil)
                .help("Remove Group")
            }
        }
        .searchable(text: $searchText, prompt: "Search Snippets")
    }
}

#Preview {
    GroupListView(
        store: Store(initialState: ShooflerFeature.State()) { ShooflerFeature() },
    )
}
