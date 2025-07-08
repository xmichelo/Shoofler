import ComposableArchitecture
import SwiftUI

@Reducer
struct AddEditSnippetFeature {
    @ObservableState
    struct State {
        var snippet: Snippet
    }
    
    enum Action {
        case setTrigger(String)
        case setDescription(String?)
        case setContent(String)
        
        case cancelButtonTapped
        case saveButtonTapped
        
        case delegate(Delegate)
        
        enum Delegate {
            case saveSnippet(Snippet)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setTrigger(let trigger):
                state.snippet.trigger = trigger
                return .none
                
            case .setDescription(let description):
                state.snippet.description = description
                return .none
                
            case .setContent(let content):
                state.snippet.content = content
                return .none
              
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }

            case .saveButtonTapped:
                return .run { [snippet = state.snippet] send in
                    await send(.delegate(.saveSnippet(snippet)))
                    await self.dismiss()
                }
            case .delegate:
                return .none
            }
            
        }
    }
}

struct AddEditSnippetView: View {
    @Bindable var store: StoreOf<AddEditSnippetFeature>
    
    var body: some View {
        VStack {
            Form {
                TextField("Trigger", text: $store.snippet.trigger.sending(\.setTrigger))
                TextField(
                    "Description",
                    text: Binding(
                        get: { store.snippet.description ?? "" },
                        set: { store.send(.setDescription($0.isEmpty ? nil : $0))}
                    )
                )
            }
            
            Divider().padding([.top, .bottom])
            
            HStack {
                Text("Content")
                Spacer()
            }
            TextEditor(text: $store.snippet.content.sending(\.setContent))
                .font(.system(.body, design: .monospaced))
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction){
                Button("Save") {
                    store.send(.saveButtonTapped)
                }
            }
            ToolbarItem(placement: .cancellationAction){
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
        .padding()
        .frame(minWidth: 600, minHeight: 400)
    }
}

#Preview {
    AddEditSnippetView(
        store: Store(initialState: AddEditSnippetFeature.State(snippet: SnippetList.sample[0])) {
            AddEditSnippetFeature()
        }
    )
}
