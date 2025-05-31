import SwiftUI

struct NavigationView: View {
    @State private var vault = Vault.sample
    @State private var selectedGroup: Group?
    @State private var selectedSnippet: Snippet?
    @State private var splitViewVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $splitViewVisibility) {
            GroupListView(vault: vault, selectedGroup: $selectedGroup)
                .navigationSplitViewColumnWidth(min: 250, ideal: 350)
        } content: {
            
            SnippetListView(
                vault: vault,
                group: selectedGroup,
                selectedSnippet: $selectedSnippet
            )
            .navigationSplitViewColumnWidth(min: 250, ideal: 350)
        }detail: {
            SnippetDetailsView(snippet: selectedSnippet)
                .navigationSplitViewColumnWidth(min: 250, ideal: 500)
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct GroupItemView: View {
    let vault: Vault
    var group: Group
    var systemImage: String = "folder"

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "folder")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.accentColor)
            VStack {
                HStack {
                    Text(group.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                }
                HStack {
                    Text(group.description ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
        }
        .padding(3)
        .badge(vault.snippets.snippetsOf(group: group.id).count)
    }
}

struct GroupListView: View {
    var vault: Vault
    
    @Binding var selectedGroup: Group?
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            List(vault.groups, selection: $selectedGroup) { group in
                NavigationLink(value: group) {
                    GroupItemView(vault: vault, group: group)
                }
            }
            .navigationTitle("")
            .listStyle(SidebarListStyle())
            
        }
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
        .searchable(text: $searchText, prompt: "Search Snippets")
    }
}

struct SnippetListView: View {
    var vault: Vault
    var group: Group?
    @Binding var selectedSnippet: Snippet?
    
    var body: some View {
        List(vault.snippets.snippetsOf(group: group?.id ?? UUID()), selection: $selectedSnippet) { snippet in
            NavigationLink(value: snippet) {
                Text(snippet.trigger)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
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
    }
}

#Preview {
    NavigationView()
        .frame(width: 1000, height: 400)
}
