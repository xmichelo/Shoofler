import SwiftUI

struct NavigationView: View {
    @State private var vault = Vault.sample
    @State private var selectedGroup: Group?
    @State private var selectedSnippet: Snippet?
    @State private var splitViewVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $splitViewVisibility) {
            GroupListView(vault: vault, selectedGroup: $selectedGroup)
        } content: {
            SnippetListView(
                vault: vault,
                group: selectedGroup,
                selectedSnippet: $selectedSnippet
            )
        } detail: {
            SnippetDetailsView(snippet: selectedSnippet)
        }
        .navigationSplitViewStyle(.balanced)
        .navigationTitle("")
    }
}

struct GroupListView: View {
    var vault: Vault
    @Binding var selectedGroup: Group?
    var body: some View {
        List(vault.groups, selection: $selectedGroup) { group in
            NavigationLink(value: group) {
                Label(group.name, systemImage: "folder")
            }
        }
        .navigationTitle("")
        .listStyle(SidebarListStyle())
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
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
    }
}

struct SnippetListView: View {
    var vault: Vault
    var group: Group?
    @Binding var selectedSnippet: Snippet?
    @State var searchText: String = ""
    
    var body: some View {
        List(vault.snippets.snippetsOf(group: group?.id ?? UUID()), selection: $selectedSnippet) { snippet in
            NavigationLink(value: snippet) {
                Text(snippet.trigger)
            }
        }
        .navigationTitle(group?.name ?? "")
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
                .help("Add Snippet")

                Button(action: {}) {
                    Image(systemName: "trash")
                }
                .help("Delete Snippet")

            }
        }
        .searchable(text: $searchText, prompt: "Search Snippets")
    }
}

struct SnippetDetailsView: View {
    var snippet: Snippet?
    
    var body: some View {
        VStack {
            if let snippet = snippet {
                Text(snippet.trigger)
                Text(snippet.content)
                Text(snippet.description ?? "")
            } else {
                EmptyView()
            }
        }
        .navigationTitle(snippet?.trigger ?? "")
    }
}

#Preview {
    NavigationView()
        .frame(width: 1000, height: 400)
}
