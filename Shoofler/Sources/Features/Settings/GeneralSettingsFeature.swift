import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct GeneralSettingsFeature {
    struct State: Equatable {
        var dummy: Bool = false
    }
    
    enum Action {
        case setDummyValue(Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}

struct GeneralSettingsView: View {
    let store: StoreOf<GeneralSettingsFeature>
    
    var body: some View {
        Text("General Settings")
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
