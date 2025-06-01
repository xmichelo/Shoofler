import ComposableArchitecture
import SwiftUI

struct GroupListView: View {
    let store: StoreOf<ShooflerFeature>
    
    @Binding var selectedGroup: Group?
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            List(store.groups.groups, selection: $selectedGroup) { group in
                NavigationLink(value: group) {
                    GroupItemView(
                        group: group,
                        badgeValue: store.snippets.snippets.snippetsOf(group: group.id).count)
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
                .disabled(selectedGroup == nil)
                .help("Edit Group")

                Button(action: {}) {
                    Image(systemName: "plus")
                }
                .help("Add Group")
                
                Button(action: {}) {
                    Image(systemName: "trash")
                }
                .disabled(selectedGroup == nil)
                .help("Remove Group")
            }
        }
        .searchable(text: $searchText, prompt: "Search Snippets")
    }
}

#Preview {
    GroupListView(
        store: Store(initialState: ShooflerFeature.State()) { ShooflerFeature() },
        selectedGroup: .constant(nil)
    )
}
