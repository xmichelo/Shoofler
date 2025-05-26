import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct GeneralSettingsFeature {
    @ObservableState
    struct State: Equatable {
        var dummy: Bool = false
    }
    
    enum Action {
        case toggledDummy(Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .toggledDummy(let isOn):
                state.dummy = isOn
                print("Dummy is now \(isOn)")
                return .none
            }
        }
    }
}

struct GeneralSettingsView: View {
    @Bindable var store: StoreOf<GeneralSettingsFeature>
    
    var body: some View {
        Section("Dummy") {
            Toggle("Dummy", isOn: $store.dummy.sending(\.toggledDummy))
        }
        .padding()
    }
}

#Preview {
    GeneralSettingsView(
        store: Store(
            initialState: GeneralSettingsFeature.State()
        ) {
            GeneralSettingsFeature()
        }
    )
}
