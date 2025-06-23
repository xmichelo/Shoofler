import ComposableArchitecture
import SwiftUI

@Reducer
struct AddEditGroupFeature {
    @ObservableState
    struct State {
        var group: Group
    }
    
    enum Action {
        case setName(String)
        case setDescription(String?)
        
        case cancelButtonTapped
        case saveButtonTapped
        
        case delegate(Delegate)
        
        enum Delegate {
            case saveGroup(Group)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setName(let name):
                state.group.name = name
                return .none
                
            case .setDescription(let description):
                state.group.description = description
                return .none
                
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }

            case .saveButtonTapped:
                return .run { [group = state.group] send in
                    await send(.delegate(.saveGroup(group)))
                    await self.dismiss()
                }
            case .delegate:
                return .none
            }
            
        }
    }
}

struct AddEditGroupView: View {
    @Bindable var store: StoreOf<AddEditGroupFeature>
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $store.group.name.sending(\.setName))
                TextField(
                    "Description",
                    text: Binding(
                        get: { store.group.description ?? "" },
                        set: { store.send(.setDescription($0.isEmpty ? nil : $0))}
                    )
                )
            }
            
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
        .frame(minWidth: 600)
    }
}

#Preview {
    AddEditGroupView(
        store: Store(initialState: AddEditGroupFeature.State(group: GroupList.sample[0])) {
            AddEditGroupFeature()
        }
    )
}
